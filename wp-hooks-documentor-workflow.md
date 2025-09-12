# How to generate WordPress plugin hook documentation and deploy it to GitHub Pages

You can automatically generate a documentation for your WordPress plugin hooks (actions and filters) using the [WP Hooks Documentor](https://github.com/10up/wp-hooks-documentor)! This workflow uses a npm package combined with GitHub Actions to publish documentation to GitHub Pages, so you don't have to separately worry about keeping your documentation up to date and publicly available. For a live example, see our [Distributor documentation](https://10up.github.io/distributor/) and [ClassifAI documentation](https://10up.github.io/classifai/).

## What you'll need

* [Well-documented hooks](#hook-documentation-examples) in your WordPress plugin code
* Node.js >= 20.0 and PHP >= 8.3 in your development environment
* A build command for the docs, along with `@10up/wp-hooks-documentor` as `devDependencies` in your [`package.json`](#packagejson)
* A [`wp-hooks-doc.json`](#wp-hooks-docjson) configuration file in your project root
* A [workflow file](#example-workflow-file) in your `.github/workflows` directory

The WP Hooks Documentor automatically scans your PHP files for hooks and generates documentation using Docusaurus. You can optionally customize the theme, styling, and content by providing custom templates in your configuration.

## Customization and Theming

WP Hooks Documentor uses Docusaurus under the hood, which provides extensive customization options. If the default theme works for your needs, you can skip the configuration entirely! However, you can customize:

* **Site branding**: Configure title, tagline and logo through the Docusaurus configuration file.
* **Styling**: Customize CSS through Docusaurus theme configuration or by providing custom CSS files.
* **Footer**: Configure footer style (light/dark) and copyright text through the configuration file or override the default footer by specifying a `templatesDir` in your configuration.

The tool generates a complete Docusaurus site, so you can leverage all of [Docusaurus's theming capabilities](https://docusaurus.io/docs/styling-layout) for advanced customization.

## Installation and Setup

### Installation

Install WP Hooks Documentor as a development dependency in your project:

```bash
npm install --save-dev @10up/wp-hooks-documentor
```

### Quick Start

1. Add npm scripts in the package.json

   ```json
   "init:docs": "wp-hooks-documentor init",
   "build:docs": "wp-hooks-documentor generate",
   ```

2. Initialize a configuration file in your project root:

   ```bash
   npm run init:docs
   ```

2. Edit the generated [`wp-hooks-doc.json`](#wp-hooks-docjson) file to match your project settings.

3. Generate documentation:

   ```bash
   npm run build:docs
   ```

## Testing locally

You can generate and preview the documentation locally before deploying:

```bash
# Generate documentation
npm run build:docs

# Navigate to the output directory (default: ./docs)
cd ./docs

# Start local development server
npm run serve
```

The documentation site will be available at `http://localhost:3000` for local preview and testing.


### Hook Documentation Examples

WP Hooks Documentor automatically detects WordPress hooks in your PHP code. Here are examples of well-documented hooks:

#### Filter Hook Example

```php
/**
 * Filters the taxonomies that should be synced.
 *
 * @since 1.0.0
 *
 * @param array   $taxonomies Associative array list of taxonomies supported by current post in the format of `$taxonomy => $terms`.
 * @param WP_Post $post       The post object.
 * 
 * @return array Associative array list of taxonomies supported by current post in the format of `$taxonomy => $terms`.
 */
$taxonomies = apply_filters( 'dt_syncable_taxonomies', $taxonomies, $post );
```

#### Action Hook Example

```php
/**
 * Fires the action after a post is pushed via Distributor before remote request validation.
 *
 * @since 2.0.0
 *
 * @param array|WP_Error              $response    The response from the remote request.
 * @param array                       $post_body   The Post data formatted for the REST API endpoint.
 * @param string                      $type_url    The Post type api endpoint.
 * @param int                         $post_id     The Post id.
 * @param array                       $args        The arguments passed into wp_insert_post.
 * @param WordPressExternalConnection $this        The Distributor connection being pushed to.
 */
do_action( 'dt_push_external_post', $response, $post_body, $type_url, $post_id, $args, $this );
```

## Code examples <span aria-hidden="true">🍝</span>

### `package.json`

```json
{
  ...
  "scripts": {
    ...
    "docs:init": "wp-hooks-documentor init",
    "docs:generate": "wp-hooks-documentor generate",
  },
  "devDependencies": {
    "@10up/wp-hooks-documentor": "^1.0.1"
  }
}
```

### `wp-hooks-doc.json`

Create this configuration file in your project root to customize the documentation generation:

```json
{
  "title": "Plugin Hooks Documentation",
  "tagline": "Hooks Documentation for the plugin",
  "url": "https://example.com",
  "baseUrl": "/",
  "repoUrl": "https://github.com/username/repo",
  "organizationName": "username",
  "projectName": "my-plugin",
  "input": ".",
  "ignoreFiles": [
    "/tests/",
    "/vendor/",
    "/node_modules/"
  ],
  "ignoreHooks": [],
  "outputDir": "./docs",
  "templatesDir": "./wp-hooks-docs",
  "footerStyle": "dark",
  "footerCopyright": "Copyright © 2025 Your Name. Built with WP Hooks Documentor."
}
```

### Example workflow file

#### `.github/workflows/build-docs.yml`

```yml
name: Build Hook Documentation

on:
 push:
   branches:
    - trunk

jobs:
  build-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4.2.2

      - name: Setup proper PHP version
        uses: shivammathur/setup-php@9e72090525849c5e82e596468b86eb55e9cc5401 # v2.32.0
        with:
          php-version: 8.3

      - name: Setup node
        uses: actions/setup-node@cdca7365b2dadb8aad0a33bc7601856ffabcc48e # v4.3.0
        with:
          node-version: 20

      - name: npm install, and build docs
        run: |
          npm install
          npm run build:docs
         
      - name: Deploy to GH Pages
        uses: peaceiris/actions-gh-pages@4f9cc6602d3f66b9c108549d475ec49e8ef4d45e # v4.0.0
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: './docs/build'
```

## Questions you may have

### What if I want to build documentation but not deploy it to GitHub Pages?

Absolutely! The workflow file is just one example. You can modify it to:
- Commit the generated documentation to your repository (e.g., in a `docs/` folder)
- Deploy to other hosting platforms like Netlify, Vercel, or AWS S3
- Generate documentation as part of your release process
- Use the documentation locally for development purposes

### What hook documentation formats are supported?

WP Hooks Documentor works with standard WordPress PHPDoc comments. It automatically detects:
- `apply_filters()` calls for filter hooks
- `do_action()` calls for action hooks
- Hook parameters and descriptions from docblock comments
- `@since` version information
- Parameter types and descriptions

### How do I exclude certain hooks from documentation?

Use the `ignoreHooks` array in your `wp-hooks-doc.json` configuration:

```json
{
  "ignoreHooks": [
    "internal_hook_name",
  ]
}
```


### Can I customize the documentation theme?

Yes! WP Hooks Documentor uses Docusaurus, so you can:
- Customize colors, fonts, and styling through configuration
- Override theme by specifying a `templatesDir`
- Add custom CSS and JavaScript
- Modify the footer, header, and navigation
- Add additional pages and content

See the [Docusaurus theming documentation](https://docusaurus.io/docs/styling-layout) for detailed customization options.

### I have another question that's not answered here.

Thanks for reading! Please [open an issue](https://github.com/10up/actions-wordpress/issues) with your question or feedback about this guide, or check out the [WP Hooks Documentor repository](https://github.com/10up/wp-hooks-documentor) for more information.

## More Actions for WordPress Developers
Do you develop your WordPress plugins on GitHub but still wrestle with SVN to deploy them to WordPress.org? We've got [some Actions](README.md) to help!

<p align="center">
<a href="http://10up.com/contact/"><img src="https://github.com/10up/.github/raw/trunk/profile/10up-github-banner.jpg" width="850"></a>
</p>
