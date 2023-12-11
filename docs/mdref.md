# Markdown Syntax Guide

Welcome to the world of Markdown! Markdown is a simple way to format text that can be easily converted to HTML. It's widely used in writing for the web, documentation, and much more. This guide will help you understand the basics of Markdown formatting.

## Headings

Headings are used to structure your document. Markdown supports six levels of headings, which are created with `#` symbols:

=== "Markdown"

    ``` markdown
    # h1 Heading
    ## h2 Heading
    ### h3 Heading
    #### h4 Heading
    ```

=== "Rendered Result"

    <h1>Heading</h1>
    <h2>Heading</h2>
    <h3>Heading</h3>
    <h4>Heading</h4>

Just add the number of `#` symbols corresponding to the level of heading you want.

## Horizontal Rules

To create a thematic break or a horizontal rule, use three or more dashes, e.g. `---` renders as:

---

This is typically used to signify a major topic change in your document.

## Emphasis

To emphasize text, you can use bold or italic formatting:

**Bold**: Wrap your text with two asterisks or underscores.

=== "Markdown"

    ``` markdown
    **This is bold text**
    __This is also bold__
    ```

=== "Rendered Result"

    **This is bold text** </br>
    __This is also bold__


*Italic*: Wrap your text with one asterisk or underscore.

=== "Markdown"

    ``` markdown
    *This is italic text*
    _This is also italic_
    ```

=== "Rendered Result"

    *This is italic text* </br>
    _This is also italic_

## Blockquotes

Blockquotes are used for quoting text from another source. Use the `>` symbol:

=== "Markdown"

    ``` markdown
    > Blockquotes can also be nested...
    >> ...by using additional greater-than signs right next to each other...
    > > > ...or with spaces between arrows.
    ```

=== "Rendered Result"

    > Blockquotes can also be nested...
    >> ...by using additional greater-than signs right next to each other...
    > > > ...or with spaces between arrows.

## Lists

Lists are a great way to organize information.

**Unordered Lists**: Start a line with `+`, `-`, or `*`:

=== "Markdown"

    ``` markdown
    + Item 1
    + Item 2
    - Subitem 2.1
    - Subitem 2.2
    ```

=== "Rendered Result"
    
    + Item 1
    + Item 2
    - Subitem 2.1
    - Subitem 2.2

**Ordered Lists**: Use numbers followed by a period:

=== "Markdown"

    ``` markdown
    1. First item
    2. Second item
    3. Third item
    ```

=== "Rendered Result"

    1. First item
    2. Second item
    3. Third item

You can also use the same number to let Markdown handle the numbering:

=== "Markdown"

    ``` markdown
    1. Item
    1. Item
    1. Item
    ```

=== "Rendered Result"

    1. Item
    1. Item
    1. Item

## Code

There are several ways to represent code in Markdown.

- **Inline Code**: For small bits of code, use backticks:

This is an inline `code` example.

- **Indented Code**: Indent your code by four spaces or a tab for block code:

```
    This is a block of code.
```

- **Fenced Code Blocks**: Use triple backticks and optionally specify the language for syntax highlighting:

```python
import tensorflow as tf
```

## Equations

MathJax allows you to display mathematical notation in Markdown documents. With MathJax, you can write complex mathematical expressions using LaTeX syntax. To use MathJax in your document, you have two main options: inline math and display math.

- **Inline Math**: For inline mathematical expressions, enclose your LaTeX code within single dollar signs `$`. This method is used when you want to include math expressions within a line of text.

=== "Markdown"

    ``` latex
    $E = mc^2$
    ```

=== "Rendered Result"

    $E = mc^2$

- **Display Math**: For larger expressions or equations that you want to display on their own line, use double dollar signs `$$` to enclose your LaTeX code. This centers the math expression and puts it on a new line.

=== "Markdown"

    ```latex
    $$
    \begin{align*}
    a^2 + b^2 &= c^2 \\
    e^{i\pi} + 1 &= 0
    \end{align*}
    $$
    ```

=== "Rendered Result"

    $$
    \begin{align*}
    a^2 + b^2 &= c^2 \\
    e^{i\pi} + 1 &= 0
    \end{align*}
    $$

Remember, for complex LaTeX expressions, ensure that your syntax is correct as MathJax will render exactly what is written within the delimiters.


## Tables

Create tables using dashes `-` for headers and pipes `|` for columns:

=== "Markdown"

    ``` markdown
    | Header 1 | Header 2 |
    | -------- | -------- |
    | Row 1    | Data     |
    | Row 2    | Data     |
    ```

=== "Rendered Result"

    | Header 1 | Header 2 |
    | -------- | -------- |
    | Row 1    | Data     |
    | Row 2    | Data     |

To align columns, use colons `:` in the header row:

=== "Markdown"

    ``` markdown
    | Left Aligned | Right Aligned | Center Aligned |
    | :----------- | ------------: | :------------: |
    | left         |         right |     center     |
    ```

=== "Rendered Result"

    | Left Aligned | Right Aligned | Center Aligned |
    | :----------- | ------------: | :------------: |
    | left         |         right |     center     |

## Links and Images

- **Links**: To create a link, wrap the link text in brackets `[ ]`, followed by the URL in parentheses `( )`:

=== "Markdown"

    ``` markdown
    This is a link to the [Google Website](https://www.google.com)
    ```

=== "Rendered Result"

    This is a link to the [Google Website](https://www.google.com)

For a link with a title, add the title in quotes after the URL:

=== "Markdown"

    ``` markdown
    This is a link to the [Google Website](https://www.google.com "Google Homepage")
    ```

=== "Rendered Result"

    This is a link to the [Google Website](https://www.google.com "Google Homepage")

- **Images**: Similar to links, but start with an exclamation mark `!`:

=== "Markdown"

    ``` markdown
    <figure markdown>
      ![Alt text](../assets/QSpace.png){ width="300" }
    </figure>
    ```

=== "Rendered Result"

    <figure markdown>
    ![Alt text](../assets/QSpace.png){ width="300" }
    </figure>

## Extended Syntax and Functionalities

In our documentation, we leverage Markdown extensions to enrich the standard Markdown syntax. These extensions are invaluable for adding advanced formatting and interactive elements that are not possible with basic Markdown. They are particularly useful in creating comprehensive and user-friendly documentation, allowing for more engaging and organized content.

For example, extensions enable the inclusion of tabbed content, detailed footnotes, custom admonition blocks, and enhanced code blocks with syntax highlighting. To explore the full range of possibilities these extensions offer, and for detailed syntax reference, please visit [MkDocs Material Extensions Reference](https://squidfunk.github.io/mkdocs-material/reference/).

&nbsp;
