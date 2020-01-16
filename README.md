# GitHub Actions for WordPress!

> Here is a collection of GitHub Actions and workflows to help with common needs for WordPress development. Specific documentation for each Action is in its respective respository, and other example workflows leveraging existing Actions can be found in this repository. Ideas for future Actions can be found in [issues](https://github.com/10up/actions-wordpress/issues).

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![MIT License](https://img.shields.io/github/license/10up/actions-wordpress.svg)](https://github.com/10up/actions-wordpress/blob/master/LICENSE)

[More information about GitHub Actions](https://github.com/features/actions/)

## Ready to use

### [Deploying a plugin to the WordPress.org repository](https://github.com/10up/action-wordpress-plugin-deploy)

Whenever you tag a new version of your plugin on GitHub, your changes will be committed to both `trunk` and the appropriate `tags` subfolder in your WordPress.org plugin repository.

### [Deploying plugin asset/readme updates to the WordPress.org repository](https://github.com/10up/action-wordpress-plugin-asset-update)

If you push to your specified branch and it only contains changes to the WordPress.org assets directory (defaults to `/.wordpress-org`) or `readme.txt`, deploy those changes to the WordPress.org plugin repository. This is useful for being able to update things like screenshots or the `Tested up to` version in between tagged releases.

### [Publishing generated hook documentation to GitHub Pages](hookdocs-workflow.md)

If you follow the [JSDoc](https://jsdoc.app/) standard for your custom WordPress actions and filters, you can use this workflow to generate documentation for your theme/plugin and publish them to GitHub Pages. For an example of the output, see the [Distributor hook docs](https://10up.github.io/distributor/).

## Planned

* Building a production-ready version into a `stable` branch or other location of choice.

## Contributing

Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

## Support Level

**Active:** 10up is actively working on this, and we expect to continue work for the foreseeable future including keeping tested up to the most recent version of WordPress.  Bug reports, feature requests, questions, and pull requests are welcome.

## Like what you see?

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10updotcom-wpengine.s3.amazonaws.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>
