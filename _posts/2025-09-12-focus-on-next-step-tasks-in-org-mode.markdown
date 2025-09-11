---
layout: post
title: Focus on next step tasks in Org mode
date: 2025-09-12
categories: [thoughts]
tags: [Org-mode,管理提升]
mathjax: false
---

Due to procrastination and the unavoidable too many tasks in my HierBEM project, there are lots of tasks accumulated in my Org mode&rsquo;s inbox, which is actually the agenda view of all headings marked as `TODO`.

Then scanning them each time for schedule what to do next becomes unbearable. So I assign a `next` tag to only a few tasks to be dealt with which are related to my current focus. This can be considered as my new inbox, which plays a role of buffering the original TODO list.

These next step tasks are further be grouped into several categories, which are marked with labels

-   Theory (`theory`): theoretical and mathematical derivation.
-   Design (`design`): architecture and data structure design, refactoring.
-   Development (`development`): project development and debugging
-   Documentation (`documentation`): write source code documentation, theoretical summary, test report, etc.
-   Management and maintenance (`management`): project management and maintenance of project repositories, both source code and website.

A new agenda view is created to display the above next step tasks:

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
