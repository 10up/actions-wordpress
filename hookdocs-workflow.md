# Publishing generated hook documentation to GitHub Pages

If you document the hooks (actions and filters) in your WordPress project using the JSDoc standard, you can automatically turn that into a reader-friendly resource using this guide! This workflow uses a combination of a build process and an Action to publish documentation to GitHub Pages so you don't have to separately worry about keeping your documentation up to date and publicly available. For a live example, see our [Distributor hook documentation](https://10up.github.io/distributor/).

## What you'll need

* [JSDoc-formatted docblocks](#dockblock-example) for your hooks
* A build command for docs, along with `jsdoc` and `wp-hookdoc` as `devDependencies` in your [`package.json`](#package-json)
* A [`hookdoc-conf.json`](#hookdoc-conf-json) in the root of your repo
* A [workflow file](#example-workflow-file) in your `.github/workflows` directory
* A [GitHub personal access token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)

You may also want to customize the base template, styling, and/or other content, which can be put in any directory so long as that's reflected in your `hookdoc-conf.json`. For instance, you may want to put templating files `.github/hookdoc-tmpl` and other Markdown content such as tutorials in `docs`.

## Templating and CSS

If the default template serves you well, by all means remove those extra config options! That said, as we got our first examples of this up and running, we realized we wanted to style things and tweak a couple things about the template.

For the template, you can override the main layout file as shown in the `hookdoc-conf.json`. Notably, we wanted to change the title structure, reference a custom CSS file, add a footer, and change a couple things about how the landing page looked. See [this example](https://github.com/10up/distributor/blob/develop/.github/hookdoc-tmpl/layout.tmpl) for the code - you'll notice things such as `<body<?js if (title === 'Home') { ?> class="home"<?js } ?>>`.

Our examples currently use a local CSS file that's copied over from a `static` assets subfolder, but if you're got multiple generated documentation sites that you want to all look the same, we'd recommend referencing a single CSS file by URL instead, which could be directly off of GitHub or uploaded elsewhere.

## Other JSDoc options

Definitely take a moment to browse [JSDoc's documentation](https://jsdoc.app) and see what else it's capable of doing. One interesting thing that you might want to do is extend the generated site to be general developer documentation with the use of [tutorial files](https://jsdoc.app/about-tutorials.html).

## Testing locally

Since this uses a command in your `package.json` rather than a hosted GitHub Action to generate the documentation, you can run `npm run build:docs` to build the documentation locally and examine it.

## Now for some copy-pasta 🍝

### Docblock example
```php
/**
  * Filters the taxonomies that should be synced.
  *
  * @since 1.0
  * @hook dt_syncable_taxonomies
  *
  * @param {array}  $taxonomies  Associative array list of taxonomies supported by current post in the format of `$taxonomy => $terms`.
  * @param {WP_Post} $post       The post object.
  *
  * @return {array} Associative array list of taxonomies supported by current post in the format of `$taxonomy => $terms`.
  */
$taxonomies = apply_filters( 'dt_syncable_taxonomies', $taxonomies, $post );
```

### `package.json`
```json
{
  ...
  "scripts": {
    ...
    "build:docs": "rm -rf hookdocs/ && jsdoc -c hookdoc-conf.json"
  },
  "dependencies": {
    ...
  },
  "devDependencies": {
    "jsdoc": "~3.6.3",
    "wp-hookdoc": "^0.2.0"
  }
}
```

### `hookdoc-conf.json`
```json
{
  "opts": {
      "destination": "hookdocs",
      "template": "node_modules/wp-hookdoc/template",
      "recurse": true,
      "readme": "./.github/hookdoc-tmpl/README.md"
  },
  "source": {
    "include": [
        "./",
        "includes"
      ],
      "includePattern": ".+\\.(php)?$"
  },
  "plugins": [
    "node_modules/wp-hookdoc/plugin",
    "plugins/markdown"
  ],
  "templates":  {
    "default": {
      "layoutFile": "./.github/hookdoc-tmpl/layout.tmpl",
      "staticFiles": {
        "include": [
          "./.github/hookdoc-tmpl/static"
        ]
      }
    }
  }
}
```

### Example workflow file 
#### `build-docs.yml`
```yml
name: Build Hook Docs

on:
 push:
   branches:
    - master

jobs:
  hookdocs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Use Node.js 10
      uses: actions/setup-node@v1
      with:
        node-version: '10.x'
    - name: npm install, and build docs
      run: |
        npm install
        npm run build:docs
    - name: Deploy to GH Pages
      uses: maxheld83/ghpages@v0.2.1
      env:
        BUILD_DIR: 'hookdocs/'
        GH_PAT: ${{ secrets.GH_PAT }}
```

## Questions you may have

### What if I want to build documentation but not deploy it to GitHub Pages?

You can definitely do that too! This workflow file is just an example of something we're currently doing at 10up - you can change it up to commit the `hookdocs` folder instead (maybe renamed `docs`), or deploy the files elsewhere entirely.

### Why JSDoc instead of PHPDoc?

The [PHPDoc parser used on WordPress.org](https://github.com/WordPress/phpdoc-parser) is a full-fledged WordPress plugin that is built to output custom post types rather than files. Rather than reinvent the wheel, we're using [an existing JSDoc plugin](https://github.com/matzeeable/wp-hookdoc) that can handle WordPress hooks. JSDoc and PHPDoc are very similar, but if you already follow the WordPress Core documentation style, you'll need to make a few tweaks such as the `@hook` line and curly braces around type names.

### How do I show a changelog for a given hook?

One limitation of JSDoc is that it doesn't support multiple `@since` annotations as a form of changelog. A workaround would be to put that information in the description instead.

### Why use a personal access token instead of the provided `GITHUB_TOKEN`?

This is currently a workaround for a [known issue](https://github.com/maxheld83/ghpages/pull/18) where using `GITHUB_TOKEN` does not actually trigger a Pages build. We hope to move to the provided `GITHUB_TOKEN` soon.

### I have another question that's not answered here.

Thanks for making it this far! Please [open up an issue](https://github.com/10up/actions-wordpress/issues) with what you're looking for or any feedback you have about this guide and we can take it from there.
