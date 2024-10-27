---
layout: post
title: org-roam-bibtex slows down Emacs when saving Org files
date: 2024-10-27
categories: [computer]
tags: [Emacs, Org-mode, Org-roam]
mathjax: false
---

After installing the package `org-roam-bibtex`, when I save a modified Org mode buffer with `org-roam-ui` enabled, it takes much longer than before to finish. Calling `profiler-start`, `profiler-stop` then `profiler-report` during the above buffer saving process, I can locate the bottleneck as below, which comes from `orb-get-attached-file`. In this function, the attached PDF file of each referenced BibTeX key in the document will be searched, which consumes a lot of time.

```text
6925  91% - command-execute
6572  86%  - funcall-interactively
6564  86%   - save-buffer
6532  86%    - basic-save-buffer
6525  86%     - run-hooks
6525  86%      - org-roam-ui--on-save # Send graphdata on saving an org-roam buffer.
6045  79%       - org-roam-ui--send-graphdata # Get roam data, make JSON, send through
                                              # websocket to org-roam-ui.
5910  78%        - seq-map
5910  78%         - apply
5910  78%          - #<compiled 0x1843c0fb8e4b25b4>
5910  78%           - mapcar
5906  77%            - org-roam-ui--create-fake-node # Create a fake node for REF without a source note.
5906  77%             - org-roam-ui--find-ref-title # Find the title of the bibtex entry keyed by ‘REF’.
5135  67%              - orb--pre-expand-template # Helper function for ‘orb--new-note’. TEMPLATE is an
                                                  # element of ‘org-roam-capture-templates’ and ENTRY is
                                                  # a BibTeX entry as returned by ‘bibtex-completion-get-entry’.
5115  67%               - orb-get-attached-file # Look up files associated with a BibTeX entry identified by CITEKEY.
4335  57%                - bibtex-completion-find-pdf # Return the path of the PDF associated with the
                                                      # specified entry KEY-OR-ENTRY.
4335  57%                 - bibtex-completion-find-pdf-in-field # Return the path of the PDF specified in
                                                                # the field ‘bibtex-completion-pdf-field’ if that file exists.
4335  57%                  + if
 780  10%                + bibtex-completion-get-entry
  16   0%               + bibtex-completion-apa-get-value
 771  10%              - bibtex-completion-get-entry
 771  10%               + bibtex-completion-get-entry1
  64   0%        + org-roam-ui--get-nodes
  48   0%        + websocket-send-text
   4   0%        + #<compiled -0xae26de3df61057f>
   3   0%        + org-roam-ui--get-cites
 480   6%       + org-roam-ui--send-variables
   7   0%     + basic-save-buffer-1
   8   0%   + execute-extended-command
 353   4%  + byte-code
 579   7% + ...
  52   0% + flyspell-post-command-hook
   9   0%   redisplay_internal (C function)
   6   0% + timer-event-handler
   3   0% + org-roam-ui--update-current-node
```

**Advice** When editing Org roam files during intensive study or research work, do not enable `org-roam-ui-mode`. Only enable it when we wan to visualize the node relationships.
