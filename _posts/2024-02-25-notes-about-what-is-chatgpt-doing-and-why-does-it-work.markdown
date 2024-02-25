---
layout: post
title: Notes about "What is ChatGPT Doing and Why does it work?"
date: 2024-02-25
categories: [thoughts]
tags: [ChatGPT,人工智能]
mathjax: true
---

The follow contents are my notes taken during reading the book &ldquo;What is ChatGPT Doing and Why does it work?&rdquo;, which is written by Stephen Wolfram. I hope they will help you get an impression or basic understanding about the capability and potential of ChatGPT as well as its limitations. Then with a critical mind, we can reconsider how to incorporate ChatGPT into our existing study, research, programming, knowledge management, or even creative activities.

-   Features of ChatGPT
    -   Collected prodigious amounts of data from the web for training
        -   Several billion human-written web pages → Trillion words
        -   Non-public web pages: 100 times more → 100 trillion words
        -   5 million digitized books → 100 billion words
        -   Text within videos and audios
    
    -   Number of weights in the neural net: 175 billion (ChatGPT 3).
    -   Generate reasonable texts from the human point of view, handle human-like or human-judge-like tasks
-   Mechanism of ChatGPT
    -   It is **not** based on theory or first principles. The neural net is only a work from engineering.
    -   Its &ldquo;creativity&rdquo; or &ldquo;ingenuity&rdquo; is based on interpolation or extrapolation.
    -   &ldquo;Reasonable&rdquo; continuation of the text based on history and knowledge base (see Figure 1)
        
        <p align="center"><img src="/figures/chatgpt-continuation-of-text.jpg" alt="ChatGPT continues words based on history and generates a meaningful sentence" /></p>
        <p align="center">Figure 1. ChatGPT continues words based on history and generates a meaningful sentence</p>
        
        Compare with the discrete-time Markov model: Let $$X_1,X_2,\cdots$$ be a sequence of random variables at discrete time points $$1,2,\cdots$$. The probability of the random variable $$X_{n+1}$$ at the time point $$n+1$$ is determined by the history $$X_1=x_1,X_2=x_2,\cdots$$, which can be described by the conditional probability:

        $$
        \begin{equation}
        P(X_{n+1}=x \vert X_1=x_1, X_2=x_2, \cdots, X_n=x_n)
        \end{equation}
        $$
        
        When $$X_{n+1}$$ only depends on its predecessor $$X_n$$, i.e. $$P(X_{n+1}=x \vert X_n=x_n)$$, the process is Markov.
        
        *It can be envisioned that the probabilistic history adopted by ChatGPT is very long.*
    
    -   Mechanism is inexplicable. It just works.
-   Feature representation and neural net structure
    -   Embedding
        
        Representation of the essence of something by an array of numbers. Similarity or correlation between different entities is measured by their distance in such high dimensional space (see Figure 2).

        <p align="center"><img src="/figures/chatgpt-words-in-semantic-space.jpg" alt="Point cloud of words in the semantic space" /></p>
        <p align="center">Figure 2. Point cloud of words in the semantic space</p>
    
    -   Transformer
        
        Pay attention to some part of the sequence of neural net layers instead of completely using generic neural net.
        
        Therefore, our subjective perception of something or some task can be incorporated into the work flow, such as feature extraction from images based on geometric properties.
    -   Initial several layers mimic the real world organisms or sensors and the output has some actual meanings.
    -   Deeper layers have not real world counterpart and cannot be understood.
-   Neural net training
    -   Under a given example input, it tries to minimize the difference between its output and the desired output by adjusting the 175 billion weights.
        
        This is a extremely high dimensional optimization problem. It is not that difficult to solve this problem because here are a lots of paths in this space which can lead us to the minimum, i.e. it is easy to jump out from local minima (see Figure 3).

        <p align="center"><img src="/figures/high-dimensional-optimization.png" alt="Find global mimimum in high dimensional space is not that difficult" /></p>
        <p align="center">Figure 3. Find global mimimum in high dimensional space is not that difficult</p>
    
    -   The training is sequential, the effects of each batch of examples are propagated layer by layer.

-   What ChatGPT can do
    -   Daily routine work which does not require accuracy, ingenuity, insight, etc.
    -   Combinatorial and variational creativity
    -   General human-like things, grammar in both daily and programming languages, simple logic such as syllogism
-   What ChatGPT lacks and cannot do
    -   Irreducible computation
        
        -   Model and theory based computation cannot be handled by ChatGPT
            
            **Structure limitation: ChatGPT is only a feed-forward network, without loops, which is incapable of nontrivial computation.**
        
        -   Requires accuracy
        
        **Trade-off between computational capability and trainability**
    -   Fidelity
        
        Everything generated by ChatGPT is human-like, consistent with or similar to common sense. Therefore, it lacks a solid proof or confirmation of the fidelity.
    
    -   Understanding
    -   Criticism
    -   Real ingenuity
-   Application of ChatGPT in scientific research
    -   Preliminary information collection
    -   Generate a summary of a specific topic: just for acquiring an initial impression, since it lacks insight and criticism.
    -   Provide prompt for new molecular forms and material ingredients.
    -   Assist coding with Copilot: should still be careful with the automatic prompt.
