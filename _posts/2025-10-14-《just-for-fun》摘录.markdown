---
layout: post
title: "《Just for Fun》摘录"
date: 2025-10-14
categories: [thoughts]
tags: [摘录]
mathjax: false
---

重新读了 Linus Torvalds 的自传《只是为了好玩》的英文版《Just for Fun》。从书中可以看出，尽管 Linus 做出了 Linux 操作系统内核与 Git 软件版本管理器这两个伟大的软件产品，并且建立起了一万多人的开发者社区，为软件的持续维护与更新提供了可靠保证，但 Linus 本人（即便是在成书时的 2001 年， Linus 31 岁，正值年轻气盛的时候）言行依旧谦虚，处世淡然。同样地，编写了 gcc 编译器、 gdb 程序调试器 、 Emacs 文本编辑器、 make 构建工具的 Richard Stallman 具有相似的品格。因此，无论是作为个人还是团体，我们没有必要刻意地向他人与世界展示自己的理论水平多么高、技术水平多么强，而应真实、谦逊地介绍我们的工作，勇于充分暴露自身的不足，持续改进、尽己所能做出贡献。所谓的“输出型学习”也不是为了人前炫耀，而仅应作为督促自己做出工作成果的激励。同时，也要警惕被国内浮躁、浮夸、侵权、盗名的坏风气侵蚀。

摘录分类整理如下。

- [因对技术的专注而忽略物与人](#org6f77eda)
- [不必证明自己有多优秀，不要宣传与布道](#orgf2ddcb6)
- [以平常心做事](#org6c90ecb)
- [对底层机制、技术细节的研究与探寻](#org6124571)
- [通过项目实践来提升技术能力与软件质量](#org6fff6f9)
- [站在巨人的肩上，做出自己的贡献](#org2f2a0a6)
- [管理的最高境界：无为之治](#orgf835e6a)
- [关于开源软件的心态与想法](#org6a366cc)
- [处世之道](#orgaf95294)
- [成功的商业领䄂其实为优秀技术人的反例](#org2cf7dc4)
- [知识产权与创造力](#org55093d8)
- [教育](#orge187068)

<a id="org6f77eda"></a>

# 因对技术的专注而忽略物与人

> Page 56 These days, I dress pretty much exclusively in vendorware, so I never have to pick out clothes. And I have a wife to make the decisions that complete my wardrobe, to pick out things like sandals and socks. So I never have to worry about it again.

> P164 This was a big deal in my life. As I mentioned, I’ve lost track of who in my family was living where at what particular time, and a lot of other things, but the path to my second computer was something that’s hard to forget.

Focus and interests dominate Linus&rsquo; mind.

> P241 The cost was $169 plus taxes, plus conversion factor, plus whatever. I thought it was outrageous at the time. Frankly, I still do. The wasted month felt like about six years. I was even more frustrated by that than I had been during the months I was waiting to buy my PC.

Linus forgets many family related details in the past, but remembers everything about his computer and operating system.

> P523 To say good-bye to all of our friends, we hosted a housecooling party, the reverse of a housewarming. Twenty people crammed into the small, recently emptied one-bedroom apartment. In good Finnish tradition, everybody got drunk.
> 
> P524 I don’t remember if my family was there or not. They must have been. Or maybe not.


<a id="orgf2ddcb6"></a>

# 不必证明自己有多优秀，不要宣传与布道

> Page 111 Most acclaimed technologists—even most of the unacclaimed ones—have this immediate desire to let you know how brilliant they are. And that they are critical players in a mission that is far more important than, say, the struggle for world peace. That wasn’t the case with Linus. In fact, his lack of ego seemed downright disarming, and made him uniquely likable amid Silicon Valley’s bombastic elite. Linus appeared to be above it all. Above the New Agers. Above the high-tech billionaires.
> 
> He seemed less like a reindeer caught in the global headlights than a delightful alien beamed down to show us the madness of our selfish ways

> P408 To me the fact that people used it was nice, and it was wonderful that I got comments back, but at the same time it was not that important. I didn’t want to spread the gospel. I was proud of having people use my code, but I don’t remember ever having the feeling that I wanted to share that with anybody. And I didn’t think it was the most important thing on Earth. I didn’t think that I was doing something really important because a hundred people were using my software. It was more like it was fun. And that’s how I feel about it today


<a id="org6c90ecb"></a>

# 以平常心做事

> P418 Linux was never something I got really upset about. I never lost any sleep over Linux.


<a id="org6124571"></a>

# 对底层机制、技术细节的研究与探寻

> P58 calculators didn’t just give you the answer. They calculated it. And they blinked a lot while doing so, mainly in order to give you some feedback that “Yes, I’m still alive, and it takes me ten seconds to do this calculation, and in the meantime I’ll blink for you to show how much work I do.”
> 
> That was fascinating. Much more exciting than a modern calculator that won’t even break into a sweat when doing something as simple as calculating a plain sine of a number. With those early devices you knew that what they did was hard. They made it very clear indeed.

> P71 You’re learning how a computer actually works. Unaware that programs exist to translate human-readable numbers into the zeros and ones that a computer understands, you just start writing programs in number form and do the conversions by hand. This is programming in machine language, and by doing it you start to do things you wouldn’t have thought possible before. You are able to push what the computer can do. You control every single small detail. You start to think about how you can do things slightly faster in a smaller space. Since there’s no abstraction layer between you and the computer, you get fairly close. This is what it’s like to be intimate with a machine.

> P93 Computers were actually better for kids when they were less sophisticated, when dweebie youngsters like me could tinker under the hood. These days, computers suffer from the same problem as cars: As they became more complex, they became more difficult for people to take apart and put back together, and, as a result, learn what they are all about.

Technical details are hidden in modern software and hardware products, while old products can give us such senses. I think that’s why some good youtube videos still present old technologies.

> P183 I had my own disassembler that I could use to create reasonably nice listings. When something didn’t work, I could go in and tell it to find the listing from a particular spot, and I could see everything that the operating system was going to do. Sometimes I used the disassembler not because something was buggy but because I was trying to understand what it was supposed to do. One of the things I hated about the QL was that it had a read-only operating system. You couldn’t change things

> P186 Both the new assembler and editor worked fine, but they were on the microdrives and couldn’t be put on the EEPROM. So I wrote my own editor and assembler and used them for all my programming. Both were written in assembly language, which is incredibly stupid by today’s standards.

Masters create their own tools.


<a id="org6fff6f9"></a>

# 通过项目实践来提升技术能力与软件质量

> And then there was still the increasing headache of buying things for the computer. It wasn’t as if there was a Sears catalogue for the Sinclair QL and you just picked up the phone and ordered more memory. The postal-order-from-England routine was getting old.

As long as we can get hands-on experience from a project and really hack into something deeply, it doesn’t matter if the device or tool is popular or not. The rationale, logic and princiles are similar and universal.

> My first year at university, the Sinclair QL sat on a desk against my first-floor bedroom window on Petersgatan, but I didn’t do much in the way of programming. Partly it was a matter of wanting to concentrate on my studies. But also, I simply found myself lacking a project to do on my computer. Lack a project and you lack enthusiasm. You’re trying to come up with something that might motivate you

Project experience is much more important than taking classes. It has been lacking for a long time in Chinese colleges, even though there are experiment or programming classes. They are merely supplementary and do not play a central role.

> P315 My original goal was to create an operating system that I could eventually use as a replacement for Minix. It didn’t have to do more than Minix, but it had to do the things in Minix that I cared about, and some other things I cared about, too

At the beginning of a project, we don‘t need to be comprehensive. We usually start from small things.

> P317 I was reading the standards from either the Sun OS manual or various books, just picking off system calls one by one and trying to make something that worked. It was really frustrating

At the start, we often have to do something which is not creative. We need to set up our own platform using existing solutions or simply reproduce them for acquiring true knowledge.

> P331 It is NOT portable (uses 386 task switching etc.), and it probably never will support anything other than AT-harddisks, as that’s all I have:-(.
> 
> P340 my operating system really wasn’t very useful. For one thing, it would crash very easily if you filled up memory or if you did anything nasty. Even if you weren’t doing anything nasty, the operating system would crash if you kept it running for any length of time. But it wasn’t meant to be run at that stage.

The project needs not be comprehensive and perfect at the beginning. We just need to start doing something.

> P353 Page-to-disk was a fairly big thing because it was something Minix had never done. It was included in version 0.12, which was released in the first week of January 1992. Immediately, people started to compare Linux not only to Minix but to Coherent, which was a small Unix clone developed by Mark Williams Company. From the beginning, the act of adding page-to-disk caused Linux to rise above the competition.

You have to do something better than existing products. Then you project will have a chance of survival.

> P354 At the time, Linux didn’t do everything Minix did, but it did most of the things people really cared about.

The project should satisfy the needs of developers and users.

> p529 The first thing I actually ended up doing was fixing some of the Linux problems that Transmeta had. The company was using a lot of multiprocessor Linux machines. I had never personally worked on the Linux SMP (Symmetric MultiProcessing) issues, and it turned out that many things didn’t really work the way they were supposed to. I took this as a personal affront, and had to fix it, of course.

A product is modified to be perfect, not born with perfection.


<a id="org2f2a0a6"></a>

# 站在巨人的肩上，做出自己的贡献

> P359 Actually, I didn’t want the money for a variety of reasons. When I originally posted Linux, I felt I was following in the footsteps of centuries of scientists and other academics who built their work on the foundations of others—on the shoulders of giants, in the words of Sir Isaac Newton. Not only was I sharing my work so that others could find it useful, I also wanted feedback (okay, and praise). It didn’t make sense to charge people who could potentially help me improve my work.


<a id="orgf835e6a"></a>

# 管理的最高境界：无为之治

> P450 I did learn fairly early that the best and most effective way to lead is by letting people do things because they want to do them, not because you want them to. The best leaders also know when they are wrong, and are capable of pulling themselves out. And the best leaders enable others to make decisions for them.

> P451 Much of Linux’s success can be attributed to my own personality flaws: 1) I’m lazy; and 2) I like to get credit for the work of others.

> P452 At the top, arbitrating disputes over the operating system’s kernel, is a leader whose instinct is, and has always been, not to lead.

> P452 I divested myself of things that didn’t hold much interest for me. The first of these was the user level, the external parts of the system that end users deal with directly, as opposed to the deep-down, internal code. First somebody volunteers to maintain it. Then the process for maintaining all the subsystems becomes organic. People know who has been active and who they can trust, and it just happens. No voting. No orders. No recounts.

> P607 What seemed to amaze them next was the administration of Linux. They couldn’t grasp how the largest collaborative project in the history of humanity could possibly be managed so effectively when the average thirty-person company typically degenerates into something resembling barnyard chaos.
> 
> Somebody coined the phrase “Benevolent Dictator” to describe how I ran the whole thing. The first time I heard the term, all I could think of was some sunny-nation general with a dark mustache handing out bananas to his starving masses. I don’t know if I feel comfortable with the Benevolent Dictator image. I control the Linux kernel, the foundation of it all, because, so far, everybody connected with Linux trusts me more than they trust anyone else. My method for managing the project with hundreds of thousands of developers is the same as it was when I coded away in my bedroom: I don’t proactively delegate as much as I wait for people to come forward and volunteer to take over things. It started when I divested myself of the responsibilities I found less interesting, like the user-level code. People stepped forward and offered to take over the subsystems. Everything filters up to me through the maintainers of those subsystems.
> 
> I approve or disapprove of their work, but mostly I let things happen naturally. If two people are maintaining similar kinds of things, I accept both of them to see which gets used. Sometimes they both get used but wind up taking different paths. Once, there was intense competition between two people who insisted on sending patches that fought each other’s patches. I refused to accept patches from either, until one of the developers lost interest. That’s how King Solomon would have handled things if he ran a preschool.
> 
> Benevolent dictator? No, I’m just lazy. I try to manage by not making decisions and letting things occur naturally. That’s when you get the best results.


<a id="org6a366cc"></a>

# 关于开源软件的心态与想法

> P362 You put six months of your life into this thing and you want to make it available and you want to get something out of it, but you don’t want people to take advantage of it. I wanted people to be able to see it, and to make changes and improvements to their hearts’ content. But I also wanted to make sure that what I got out of it was to see what they were doing. I wanted to always have access to the sources so that if they made improvements I could use those improvements myself. It made sense to me that the way for Linux to develop into the best possible technology was to keep it pure. If money was to get involved, things would get murky. If you don’t let money enter the picture, you won’t have greedy people.

> P369 The new copyright was included in version 0.12, but I remember lying awake at night after releasing it, nervous about what commercial interests would do to the system. Looking back now, it seems ridiculous to have been so worried because the commercial interest was relatively small.

> P370 And there are nagging fears that companies in places like China won’t honor the GPL. Practically nothing in their legal system prevents them from breaking the copyright, and in a real sense it’s not worth the trouble to go after people who would try to do something illegal. That’s what big software companies and the music industry have tried to do and it hasn’t been overwhelmingly successful. My fears are mitigated by reality. Somebody might do it for a while, but it is the people who actually honor the copyright, who feed back their changes to the kernel and have it improved, who are going to have a leg up. They’ll be part of the process of upgrading the kernel. By contrast, people who don’t honor the GPL will not be able to take advantage of the upgrades, and their customers will leave them. I hope.

> P820 Ideology isn’t what has sold the open source model. It started gaining attention when it was obvious that open source was the best method of developing and improving the highest quality technology.

> P803 In a society where survival is more or less assured, money is not the greatest of motivators. It’s been well established that folks do their best work when they are driven by a passion.

> P811 It’s like letting the universe take care of itself. By not controlling the technology, you are not limiting its uses. You make it available and people make local decisions—to use it as a launching pad for their own products and services. And while most of those decisions don’t make sense in the larger scale of things, they actually work really well. This is not about trying to spread Linux. It’s about making Linux available and then letting it spread itself. And this doesn’t apply only to Linux. It applies to any project that’s open.

> P822 When folks first hear about the possibility of opening up an existing commercial project, they tend to ask the same questions. One question has to do with how people inside the company would feel about the possibility of having an outsider produce work that is better than their own—and having that so publicly noticeable. I think they should feel great about it, and great that they are getting paid for not even doing most of the work. In that regard, open source—or open anything, for that matter—is unforgiving. It shows who can get the job done, who is better. You can’t hide behind managers.


<a id="orgaf95294"></a>

# 处世之道

> P639 This is the place where I slip in my golden rules. Number One is: “Do unto others as you would want them to do unto you.” If you follow that rule, you’ll always know how to behave in any situation. Number Two is: “Be proud of what you do.” Number Three: “And have fun doing it.”

> P672 The point about open source has never been that I’m more accessible than anybody else. It’s never been that I’m more accessible than anybody else. It’s never been that I’m more open to other people’s suggestions. That’s never been the issue. The issue is that even if I’m the blackest demon from Hell, even if I’m outright evil, people can choose to ignore me because they can just do the stuff themselves. It’s not about me being open, it’s about them having the power to ignore me. That’s important.


<a id="org2cf7dc4"></a>

# 成功的商业领䄂其实为优秀技术人的反例

> P545 Steve was Steve, exactly as the press portrays him. He was interested in his own goals, and especially the marketing side. I was interested in the technical side, and not very interested in either his goals or his arguments. His main argument was that if I wanted to get the desktop market I should come join forces with Apple. My reaction was: Why should I care? Why would I be interested in the Apple story? I didn’t think there was anything interesting in Apple. And my goal in life was not to take over the desktop market

Steve Jobs.

> P546 He didn’t use very many arguments. He just basically took it for granted that I would be interested. He was clueless, unable to imagine that there could be entire segments of the human race who weren’t the least bit concerned about increasing the Mac’s market share. I think he was truly surprised at how little I cared about how big a market the Mac had—or how big a market Microsoft has. And I can’t blame him for not knowing in advance how much I dislike Mach.


<a id="org55093d8"></a>

# 知识产权与创造力

> P724 To many people, including me, intellectual property is all about human inventiveness, about the very thing that makes us humans instead of animals (that, and thumbs, of course). And in that setting, the very name “intellectual property” is an affront: It’s not property to be sold like chattel, it’s the act of creation, it’s the greatest thing any human can ever do. It’s Art, with a capital A. It’s the Mona Lisa, but it’s also the end result of a long night of programming, and it’s an end result that you as a programmer are damned proud of. It’s something so precious that selling it isn’t even possible: It’s indelibly a part of who you are.

> 725 That kind of creativity—whether it be in the form of painting, music, sculpture, writing, or programming—should be sacred. The creator and the thing he or she created have a bond that cannot be severed. It’s like the bond between a mother and child, or between bad Chinese food and MSG. But at the same time it’s something that everybody in the whole world should be able to be part of, because it is humanity.


<a id="orge187068"></a>

# 教育

> P122 My high school wasn’t one of those institutions for exceptionally smart or ambitious kids, which are common in most U.S. cities. Such schools are pretty much against how Finland works. Finnish schools don’t separate out the good students—or the losers, for that matter. However, each school did have its specialty, a subject that was not required but that you couldn’t get at any other school.

> P132 And there was ample time for it to happen: I studied at the university for eight years, emerging with nothing more than a mere master’s degree.

Just slow down, don’t compete or compare with others.

> P133 But that first year was a blur of streetcar commutes between lecture classes and my bedroom, which was gathering piles of books and computer equipment. I’d lie in bed reading a Douglas Adams sci-fi thriller, then toss it on the floor and pick up a physics text, then roll out of bed and sit at the computer writing a program for a new game. The kitchen is right outside the bedroom and I’d stumble in for some coffee or corn crunchies

Don’t treat college students as high school youngsters. Don’t lock them within the campus. Our Chinese students have been institutionalized since kindergarten. This phenomenon now lasts till college or even their deaths.
