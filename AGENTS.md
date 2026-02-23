# AGENTS.md

Minimal academic personal website for Cheng Guo, built on the
[Academic Pages](https://github.com/academicpages/academicpages.github.io)
template (a fork of Minimal Mistakes by Michael Rose). Two pages only:
homepage (bio/education/awards) and publications list. CV is a PDF download.
Hosted on GitHub Pages at `cgasu.github.io`.

## Build & Serve Commands

```bash
# Install Ruby dependencies
bundle install

# Install JS dependencies
npm install

# Build and serve locally with live reload
bundle exec jekyll serve -l -H localhost

# Serve with Docker (alternative)
docker compose up

# Build JS bundle (concatenate + minify into assets/js/main.min.js)
npm run build:js

# Watch JS files for changes and rebuild automatically
npm run watch:js
```

### There are no tests or linters

This project has no test suite, no test framework, and no linting/formatting
tools configured. There are no `*.test.*` or `*.spec.*` files. Validation is
done by building the site and checking the output manually.

To verify changes don't break the build:
```bash
bundle exec jekyll build
```

## Project Structure

```
_config.yml          # Main Jekyll site configuration
_data/               # Structured data (YAML/JSON): navigation, authors, ui-text
_includes/           # Reusable HTML/Liquid partials (analytics, comments, head, footer)
_layouts/            # Page layout templates (default, single, archive, talk, cv-layout)
_pages/              # Standalone pages (about, publications)
_publications/       # Academic publication entries (date-prefixed Markdown)
_sass/               # SCSS source (include/, layout/, theme/, vendor/)
assets/css/          # CSS entry point (main.scss) + standalone CSS
assets/js/           # JavaScript source (_main.js, theme.js) and output (main.min.js)
assets/js/plugins/   # jQuery plugins (greedy-navigation, smooth-scroll)
files/               # Downloadable files (CV.pdf)
images/              # Site images (profile, favicons)
scripts/             # Utility scripts (CV markdown-to-JSON conversion)
markdown_generator/  # Jupyter notebooks/Python to generate content from TSV
talkmap/             # Talk map visualization (Leaflet)
```

Layout inheritance: `compress.html` -> `default.html` -> `single.html` / `archive.html` / `talk.html`

## Code Style Guidelines

### File Naming

- Content files: date-prefixed kebab-case (`YYYY-MM-DD-slug-name.md`)
- Layouts, includes, pages: `kebab-case.html` or `kebab-case.md`
- SCSS partials: underscore-prefixed kebab-case (`_base.scss`, `_page.scss`)
- JS source files: kebab-case (`_main.js`, `theme.js`, `collapse.js`)
- Python scripts: `snake_case.py`
- Jekyll directories use `_` prefix (`_pages`, `_includes`, `_layouts`, `_sass`)

### Indentation & Formatting

- **HTML/Liquid, SCSS, JS, YAML:** 2-space indentation
- **Python:** 4-space indentation
- Semicolons are required in JavaScript
- Double quotes for HTML attributes and YAML values
- JavaScript uses double quotes predominantly; Python mixes single/double
- No enforced line length limit, but keep lines reasonable
- `_config.yml` uses aligned colons with whitespace padding for readability

### Naming Conventions

| Context | Convention | Examples |
|---------|-----------|----------|
| CSS/SCSS classes | BEM (`block__element--modifier`) | `.page__title`, `.btn--primary`, `.archive__item-teaser` |
| SCSS variables | `$kebab-case` | `$primary-color`, `$type-size-1`, `$global-font-family` |
| CSS custom properties | `--global-kebab-case` | `--global-bg-color`, `--global-text-color` |
| JS variables/functions | `camelCase` | `setTheme`, `plotlyElements`, `toggleTheme` |
| jQuery-cached elements | `$camelCase` prefix | `$nav`, `$btn`, `$vlinks` |
| Python functions/vars | `snake_case` | `parse_markdown_cv`, `section_content` |
| Python classes | `PascalCase` | `DateTimeEncoder` |
| Python constants | `UPPERCASE` | `TIMEOUT` |
| Liquid template vars | `snake_case` | `base_path`, `seo_url`, `title_shown` |
| Front matter keys | `snake_case` | `author_profile`, `read_time`, `paperurl` |

### SCSS / CSS

- Vendor SCSS in `_sass/vendor/` -- never modify these files
- Custom styles organized by concern: `layout/` (structural), `theme/` (colors), `include/` (mixins)
- Theming uses CSS custom properties (`--global-*`) with light/dark variants
- BEM class naming throughout; nesting stays within 3-4 levels max
- Section headers use banner comments: `/* ========== SECTION NAME ========== */`
- Units: `em` for font sizes via `$type-size-*`; `px` for breakpoints

### JavaScript

- Use `let` / `const` (prefer `const` for immutable bindings); avoid `var`
- No module bundler -- JS is concatenated via `uglify-js` (see `npm run build:js`)
- ES module `import` only in `_main.js` for local modules (`theme.js`)
- jQuery plugins follow existing patterns in `assets/js/plugins/`
- After editing JS source files, run `npm run build:js` to regenerate `main.min.js`

### HTML / Liquid Templates

- Every layout and include should begin with `{% include base_path %}`
- Use `{% if %}` guards before rendering optional content
- Apply Liquid filters for sanitization: `{{ value | markdownify | strip_html | escape_once }}`
- Use semantic HTML5 elements (`<article>`, `<section>`, `<nav>`, `<main>`)
- Include Schema.org microdata (`itemscope`, `itemtype`, `itemprop`) for SEO
- Use Font Awesome 6 classes (`fa-solid fa-*`, `fab fa-fw fa-*`) and Academicons (`ai ai-*`)

### Content (Markdown) Files

- Always include YAML front matter between `---` delimiters
- Required front matter keys: `title`, `permalink`, `layout`
- Collection items (publications, talks, teaching) are date-prefixed and include
  `collection`, `date`, `venue`, and `excerpt`
- Publications also use: `category`, `paperurl`, `slidesurl`, `bibtexurl`, `citation`
- Talks also use: `type`, `location`

### Python Scripts

- Follow PEP 8 style (4-space indent, `snake_case` functions, `PascalCase` classes)
- Use `try/except` with specific exception types; print errors with f-strings
- Guard file operations with `os.path.exists()` checks
- No type annotations are currently used, but they are welcome in new code

### Comments

- SCSS/JS section headers: `/* ========== SECTION NAME ========== */`
- JS inline: `//` single-line comments
- Python: docstrings (`"""..."""`) for functions; `#` for inline comments
- HTML: `<!-- description -->` for structural landmarks
- Liquid: `{% comment %}...{% endcomment %}`

### Error Handling

- Python: `try/except` with specific exception types; `print()` for error output
- JavaScript: defensive conditionals (`if (elements.length > 0)`); no `try/catch`
- Liquid: `{% if %}` guards and `| default:` filters for missing values
- Shell scripts: check `$?` exit codes and `[ -f ]` file existence before proceeding

## Git & Deployment

- Branch: `master` (deployed to GitHub Pages automatically)
- Remote: `https://github.com/cgasu/cgasu.github.io.git`
- `_site/`, `.sass-cache/`, `node_modules/`, `Gemfile.lock`, `package-lock.json`
  are all gitignored
- Changes pushed to `master` trigger GitHub Pages rebuild
