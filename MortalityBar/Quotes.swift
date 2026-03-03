import Foundation

struct Quotes {
    /// Weekday-keyed commentary. Calendar weekday: 1=Sunday, 7=Saturday.
    static let weekdayQuotes: [Int: [String]] = [
        1: [ // Sunday
            "Sunday scaries hit different when you can count the Sundays left.",
            "Rest day? More like one fewer day to rest.",
            "Sunday: the day you pretend tomorrow won't come.",
            "Another Sunday spent not climbing Kilimanjaro.",
            "The week resets. Your countdown doesn't.",
        ],
        2: [ // Monday
            "Another Monday. You've been 'starting fresh' for how many of these?",
            "Monday motivation: you literally cannot afford to waste this one.",
            "Rise and grind. The clock is grinding whether you rise or not.",
            "Happy Monday! Each one is a limited edition.",
            "Monday again. Statistically, one of these will be your last.",
        ],
        3: [ // Tuesday
            "Tuesday: Monday's sequel nobody asked for.",
            "It's only Tuesday and you've already wasted hours scrolling.",
            "Fun fact: 'Tuesday' comes from the Norse god of war. Fight for your time.",
            "Tuesday is proof that even the calendar is just padding.",
            "Another Tuesday. At least it's not a Monday. Small wins.",
        ],
        4: [ // Wednesday
            "Hump day! You're over the hump of... this week. And life, possibly.",
            "Wednesday: close enough to see the weekend, far enough to suffer.",
            "Midweek check-in: are you living or just existing between weekends?",
            "Half the week gone. Half your life? Check the numbers above.",
            "It's Wednesday, my dude. Make it count.",
        ],
        5: [ // Thursday
            "Thursday. You've been 'starting fresh Monday' for how many Mondays now?",
            "Almost Friday! Which is almost Saturday, which is almost over.",
            "Thursday: the day you start pretending you'll be productive tomorrow.",
            "One more day until the socially acceptable time to give up for the week.",
            "Thursday energy: too late to start, too early to quit.",
        ],
        6: [ // Friday
            "TGIF! Only a finite number of those left, by the way.",
            "Friday! Time to do in two days what you promised yourself all week.",
            "Weekend plans? Bold of you to assume infinite weekends.",
            "Friday vibes are great. Savor them. They're numbered.",
            "The weekend is here. Use it wisely. Or don't. It's your countdown.",
        ],
        7: [ // Saturday
            "Saturday: the day you'll 'finally relax' and then doom-scroll for 6 hours.",
            "Weekend! Quick, do something meaningful before Monday comes for you.",
            "Another Saturday spent exactly like the last one. Just saying.",
            "Saturday is nature's way of saying 'you have less of these than you think.'",
            "Carpe Saturday. There are only so many left.",
        ],
    ]

    /// General quotes not tied to a day.
    static let general: [String] = [
        "Every minute you spend reading this is a minute you'll never get back.",
        "Your life is basically a progress bar. Check where you are.",
        "Time flies. It's the only thing that does without a boarding pass.",
        "You've already lived through most of your summers. Just saying.",
        "Memento mori. But make it an app.",
        "This app doesn't judge. The numbers do that on their own.",
        "Plot twist: knowing the countdown doesn't actually add time.",
        "At least you're not spending this moment in a meeting. Unless you are.",
        "Some people count blessings. You count remaining Fridays.",
        "The good news: you're alive! The other news: see above.",
        "Time is the only currency you can't earn more of.",
        "Fun fact: you'll spend about 26 years sleeping. You're welcome.",
        "Another day, another 0.003% of your life gone.",
        "Your ancestors survived plagues for you to see this notification.",
        "Life expectancy is an average. Be above average. Or don't.",
        "Nobody on their deathbed ever said 'I wish I'd checked more emails.'",
        "The universe is 13.8 billion years old. You get maybe 80. No pressure.",
        "You're not stuck in traffic. You're the traffic. And you're mortal.",
        "Somewhere, someone your age just did the thing you keep putting off.",
        "Your screen time report is scarier than this app.",
        "You've spent more hours on Netflix than you'll spend retired. Probably.",
        "The best time to plant a tree was 20 years ago. The clock is ticking on the second best time.",
        "Imagine explaining to your 80-year-old self what you did today.",
        "One day you'll eat your last meal and you won't even know it.",
        "There's a last time for everything. Most of them, you won't notice.",
        "You have fewer summers left than photos in your camera roll.",
        "Right now is the youngest you'll ever be again.",
        "Your to-do list will outlive you if you're not careful.",
        "Every 'I'll do it tomorrow' costs exactly one day.",
        "The hourglass doesn't pause for weekends.",
    ]

    /// Dynamic templates that use actual calculated numbers.
    /// Each closure takes a LifeCalculator and returns a personalized quote.
    static let dynamicTemplates: [(Int, Int, Int, Int, Int, Int) -> String] = [
        // (daysLeft, weeksLeft, mondaysLeft, summersLeft, fridaysLeft, mealsLeft) -> String
        { d, _, m, _, _, _ in "You have \(m.formatted()) Mondays left. Make them count." },
        { d, _, _, _, _, _ in "That's \(d.formatted()) sunrises you'll never see again." },
        { _, _, _, s, _, _ in "\(s) summers. That's it. Choose your beaches wisely." },
        { _, _, _, _, f, _ in "\(f.formatted()) Fridays remain. TGIF hits different now." },
        { _, _, _, _, _, m in "\(m.formatted()) meals left. Maybe skip the sad desk lunch." },
        { _, _, _, s, _, _ in "\(s) more Christmases. Start buying better gifts." },
        { d, _, _, _, _, _ in "\(d.formatted()) days. That's your whole inventory. Spend wisely." },
        { _, w, _, _, _, _ in "\(w.formatted()) weeks. Sounds like a lot until you count them." },
        { _, _, m, _, _, _ in "Only \(m.formatted()) more Monday morning alarms. Silver lining?" },
        { _, _, _, s, _, _ in "\(s) more New Year's resolutions you'll probably break." },
        { _, _, _, _, f, _ in "\(f.formatted()) Friday nights left. Stop staying in." },
        { d, _, _, _, _, _ in "In \(d.formatted()) days, none of your worries will matter." },
        { _, w, _, _, _, _ in "That's \(w.formatted()) weekends. Use them or lose them." },
        { _, _, _, s, _, _ in "\(s) more falls. \(s) more chances to actually go leaf-peeping." },
        { _, _, m, _, _, _ in "\(m.formatted()) Mondays is a lot. But it's also... not." },
        { _, _, _, _, _, m in "\(m.formatted()) meals. At least make dinner interesting tonight." },
        { d, _, _, _, _, _ in "\(d.formatted()) days left and you're reading a menu bar app." },
        { _, _, _, s, _, _ in "You've got \(s) birthdays left. Make each cake count." },
        { _, w, _, _, _, _ in "\(w.formatted()) weeks left. That's only \(w / 52) year-shaped blocks." },
        { _, _, m, _, _, _ in "Imagine a jar with \(m.formatted()) marbles. Remove one every Monday." },
        { _, _, _, _, f, _ in "\(f.formatted()) more chances to actually leave work on time on a Friday." },
        { _, _, _, s, _, _ in "\(s) more springs. Have you ever actually stopped to smell flowers?" },
        { d, _, _, _, _, _ in "\(d.formatted()) days to become who you were meant to be. Or not. Your call." },
        { _, _, _, _, _, m in "Only \(m.formatted()) meals left. Life's too short for bad coffee." },
        { _, w, _, _, _, _ in "\(w.formatted()) weeks. A lot of Netflix, or a lot of living. Pick one." },
        { _, _, m, _, _, _ in "\(m.formatted()) Monday mornings. That's the bad news. The good news: also \(m.formatted()) Friday evenings." },
        { d, _, _, _, _, _ in "Fun math: \(d.formatted()) days is roughly \((d / 365).formatted()) trips around the sun." },
        { _, _, _, s, _, _ in "\(s) more pool days. Invest in sunscreen and memories." },
        { _, _, _, _, f, _ in "\(f.formatted()) paychecks left, give or take. Make them worthwhile." },
        { d, _, _, _, _, _ in "\(d.formatted()) tomorrows. Stop acting like there's an infinite supply." },
    ]

    /// Returns a deterministic quote for today, mixing static + dynamic quotes.
    static func reaper(
        daysLeft: Int,
        weeksLeft: Int,
        mondaysLeft: Int,
        summersLeft: Int,
        fridaysLeft: Int,
        mealsLeft: Int
    ) -> String {
        let weekday = Calendar.current.component(.weekday, from: Date())
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1

        // Build the dynamic quotes for today
        let dynamicPool = dynamicTemplates.map {
            $0(daysLeft, weeksLeft, mondaysLeft, summersLeft, fridaysLeft, mealsLeft)
        }

        // Combine: today's weekday quotes + general + dynamic
        let staticPool = (weekdayQuotes[weekday] ?? []) + general
        let fullPool = staticPool + dynamicPool

        let index = dayOfYear % fullPool.count
        return fullPool[index]
    }
}
