import AppKit
import ApplicationServices

@_silgen_name("_AXUIElementGetWindow")
func windowID(_ element: AXUIElement, _ id: UnsafeMutablePointer<CGWindowID>) -> AXError

struct Shortcut: Equatable {
    let key: Int64
    let flags: CGEventFlags
    static let mask: CGEventFlags = [.maskCommand, .maskAlternate, .maskShift, .maskControl]
    static let maximize = Shortcut(key: 113, flags: [.maskCommand, .maskAlternate])
    static let reasonable = Shortcut(key: 90, flags: [])
    static let layouts: [Shortcut] = [
        Shortcut(key: 113, flags: []), Shortcut(key: 106, flags: []),
        Shortcut(key: 64, flags: []), Shortcut(key: 113, flags: .maskCommand),
        Shortcut(key: 80, flags: []), reasonable
    ]
}

struct History {
    var layout = Shortcut.reasonable
    var maximized = false

    mutating func resolve(_ action: Shortcut) -> Shortcut {
        if action == .maximize {
            maximized.toggle()
            return maximized ? .maximize : layout
        }
        layout = action
        maximized = false
        return action
    }
}

struct Window: Hashable {
    let pid: pid_t
    let launched: Date?
    let id: CGWindowID
}

final class Tracker {
    var tap: CFMachPort?
    var histories: [Window: History] = [:]
    var held: [Int64: Shortcut] = [:]

    func focusedWindow() -> Window? {
        guard let app = NSWorkspace.shared.frontmostApplication else { return nil }
        let element = AXUIElementCreateApplication(app.processIdentifier)
        // A hung app must not stall the global keyboard event stream.
        AXUIElementSetMessagingTimeout(element, 0.05)
        var value: CFTypeRef?
        guard AXUIElementCopyAttributeValue(element, kAXFocusedWindowAttribute as CFString, &value) == .success,
              let value, CFGetTypeID(value) == AXUIElementGetTypeID() else { return nil }
        var id: CGWindowID = 0
        guard windowID(value as! AXUIElement, &id) == .success else { return nil }
        return Window(pid: app.processIdentifier, launched: app.launchDate, id: id)
    }

    func rewrite(_ event: CGEvent, to shortcut: Shortcut) {
        event.setIntegerValueField(.keyboardEventKeycode, value: shortcut.key)
        event.flags = event.flags.subtracting(Shortcut.mask).union(shortcut.flags)
    }

    func handle(_ type: CGEventType, _ event: CGEvent) -> Unmanaged<CGEvent>? {
        if type == .tapDisabledByTimeout || type == .tapDisabledByUserInput {
            if let tap { CGEvent.tapEnable(tap: tap, enable: true) }
            held.removeAll()
            return Unmanaged.passUnretained(event)
        }
        let key = event.getIntegerValueField(.keyboardEventKeycode)
        if type == .keyUp {
            if let replacement = held.removeValue(forKey: key) { rewrite(event, to: replacement) }
            return Unmanaged.passUnretained(event)
        }
        let shortcut = Shortcut(key: key, flags: event.flags.intersection(Shortcut.mask))
        guard shortcut == .maximize || Shortcut.layouts.contains(shortcut) else {
            return Unmanaged.passUnretained(event)
        }
        // Holding F must not oscillate between maximize and restore.
        if event.getIntegerValueField(.keyboardEventAutorepeat) != 0 { return nil }
        guard let window = focusedWindow() else { return Unmanaged.passUnretained(event) }
        if histories.count >= 128 && histories[window] == nil { histories.removeAll(keepingCapacity: true) }
        var history = histories[window] ?? History()
        let replacement = history.resolve(shortcut)
        histories[window] = history
        held[key] = replacement
        rewrite(event, to: replacement)
        return Unmanaged.passUnretained(event)
    }

    func start() {
        guard AXIsProcessTrusted() else {
            fputs("Enable Accessibility for karabiner-window-toggle-bin, then restart the login agent.\n", stderr)
            exit(1)
        }
        let mask = (CGEventMask(1) << CGEventType.keyDown.rawValue) |
                   (CGEventMask(1) << CGEventType.keyUp.rawValue)
        tap = CGEvent.tapCreate(tap: .cgSessionEventTap, place: .headInsertEventTap,
            options: .defaultTap, eventsOfInterest: mask,
            callback: { _, type, event, context in
                guard let context else { return Unmanaged.passUnretained(event) }
                return Unmanaged<Tracker>.fromOpaque(context).takeUnretainedValue().handle(type, event)
            }, userInfo: Unmanaged.passUnretained(self).toOpaque())
        guard let tap else {
            fputs("Cannot create window shortcut event tap. Check Accessibility permission.\n", stderr)
            exit(1)
        }
        CFRunLoopAddSource(CFRunLoopGetCurrent(), CFMachPortCreateRunLoopSource(nil, tap, 0), .commonModes)
        CGEvent.tapEnable(tap: tap, enable: true)
        // No timers, polling, subprocesses, disk history, or frame manipulation.
        CFRunLoopRun()
    }
}

if CommandLine.arguments.contains("--self-test") {
    for layout in Shortcut.layouts {
        var history = History()
        precondition(history.resolve(layout) == layout)
        precondition(history.resolve(layout) == layout)
        precondition(history.resolve(.maximize) == .maximize)
        precondition(history.resolve(.maximize) == layout)
        precondition(history.resolve(.maximize) == .maximize)
        precondition(history.resolve(.reasonable) == .reasonable)
        precondition(history.resolve(.maximize) == .maximize)
        precondition(history.resolve(.maximize) == .reasonable)
    }
    var a = History()
    var b = History()
    _ = a.resolve(Shortcut.layouts[0])
    _ = b.resolve(Shortcut.layouts[1])
    _ = a.resolve(.maximize)
    _ = b.resolve(.maximize)
    precondition(a.resolve(.maximize) == Shortcut.layouts[0])
    precondition(b.resolve(.maximize) == Shortcut.layouts[1])
    print("PASS: six layouts, duplicate actions, toggles, changed layouts, independent window history")
} else {
    Tracker().start()
}
