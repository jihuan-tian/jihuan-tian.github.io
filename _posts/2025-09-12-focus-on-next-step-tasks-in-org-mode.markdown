---
layout: post
title: Focus on next step tasks in Org mode
date: 2025-09-12
categories: [thoughts]
tags: [Org-mode,管理提升]
mathjax: false
---

Due to procrastination and unavoidable too many tasks in my HierBEM project, there are lots of tasks having been accumulated in my GTD inbox, which is actually the Org agenda view of all headings marked as `TODO`.

Then scanning tasks in the inbox each time for scheduling what to do next become a headache. So I assign a `next` tag to only a few tasks (limited within 20) to be dealt with which are related to my current focus. This smaller task collection is my lean GTD inbox, which plays a role of buffering the original TODO list.

These next step tasks are further grouped into several categories, which are marked with these labels:

-   Theory (`theory`): theoretical and mathematical derivation.
-   Design (`design`): architecture and data structure design, refactoring.
-   Development (`development`): project development and debugging
-   Documentation (`documentation`): write source code documentation, theoretical summary, test report, etc.
-   Management and maintenance (`management`): project management and maintenance of project repositories, both source code and website.

Among these categories, &ldquo;Theory&rdquo;, &ldquo;Design&rdquo; and &ldquo;Development&rdquo; correspond to my [three working modes]({% post_url 2021-10-12-数值算法从理论到实践的三种工作模式 %}) during HierBEM development.

A new customized Org agenda view is also created to display the above next step tasks:

```elisp
(set org-agenda-custom-commands
     '(
       ;; Next step tasks, which are limited to 10 items per category. Some of
       ;; these categories correspond to my three working modes: theoretical
       ;; derivation, refactor and design, algorithm development.
       ("n" "Focused next actions"
        (
	 (tags "next+theory" ((org-agenda-overriding-header "📚 Theory")))
	 (tags "next+design" ((org-agenda-overriding-header "💡 Design")))
	 (tags "next+development" ((org-agenda-overriding-header "💻 Development")))
	 (tags "next+documentation" ((org-agenda-overriding-header "📄 Documentation")))
         (tags "next+management" ((org-agenda-overriding-header "🛠 Management and maintenance")))))))
```

{{ "2025-09-12-focus-on-next-step-tasks-in-org-mode" | backlink }}
