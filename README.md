# GitHub Actions for WordPress!

> Here is a collection of GitHub Actions and workflows to help with common needs for WordPress development. Specific documentation for each Action is in its respective respository, and other example workflows leveraging existing Actions can be found in this repository. Ideas for future Actions can be found in [issues](https://github.com/10up/actions-wordpress/issues).

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![MIT License](https://img.shields.io/github/license/10up/actions-wordpress.svg)](https://github.com/10up/actions-wordpress/blob/master/LICENSE)

[More information about GitHub Actions](https://github.com/features/actions/)

## Ready to use

The following GitHub Actions are published,  available to use, and actively supported by 10up.

### [Deploying a plugin to the WordPress.org repository](https://github.com/10up/action-wordpress-plugin-deploy)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](https://github.com/10up/action-wordpress-plugin-deploy/blob/develop/README.md#support-level) [![Release Version](https://img.shields.io/github/release/10up/action-wordpress-plugin-deploy.svg)](https://github.com/10up/action-wordpress-plugin-deploy/releases/latest) [![MIT License](https://img.shields.io/github/license/10up/action-wordpress-plugin-deploy.svg)](https://github.com/10up/action-wordpress-plugin-deploy/blob/develop/LICENSE)

Whenever you tag a new version of your plugin on GitHub, your changes will be committed to both `trunk` and the appropriate `tags` subfolder in your WordPress.org plugin repository.

### [WordPress.org Plugin Build Zip Archive](https://github.com/10up/action-wordpress-plugin-build-zip)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![Release Version](https://img.shields.io/github/release/10up/action-wordpress-plugin-build-zip.svg)](https://github.com/10up/action-wordpress-plugin-build-zip/releases/latest) [![MIT License](https://img.shields.io/github/license/10up/action-wordpress-plugin-build-zip.svg)](https://github.com/10up/action-wordpress-plugin-build-zip/blob/develop/LICENSE)

This Action will build a zip archive of your WordPress plugin and attach that archive as an artifact, allowing you to download and test prior to deploying any changes to WordPress.org.  This gives you the peace of mind knowing you've tested exactly what will be deployed.  Recommended to be used in conjunction with our [WordPress.org Plugin Deploy Action](https://github.com/10up/action-wordpress-plugin-deploy) as both Actions create the archive in the same way. An ideal workflow is to run this Action first and test the zip archive it provides.  Once testing passes, then run our deploy Action to push changes to WordPress.org.

### [Deploying plugin asset/readme updates to the WordPress.org repository](https://github.com/10up/action-wordpress-plugin-asset-update)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](https://github.com/10up/action-wordpress-plugin-asset-update/blob/develop/README.md#support-level) [![Release Version](https://img.shields.io/github/release/10up/action-wordpress-plugin-asset-update.svg)](https://github.com/10up/action-wordpress-plugin-asset-update/releases/latest) [![MIT License](https://img.shields.io/github/license/10up/action-wordpress-plugin-asset-update.svg)](https://github.com/10up/action-wordpress-plugin-asset-update/blob/develop/LICENSE)

If you push to your specified branch and it only contains changes to the WordPress.org assets directory (defaults to `/.wordpress-org`) or `readme.txt`, deploy those changes to the WordPress.org plugin repository. This is useful for being able to update things like screenshots or the `Tested up to` version in between tagged releases.

### [PHP linting without additional codebase dependencies](https://github.com/10up/wpcs-action)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](https://github.com/10up/wpcs-action/blob/develop/README.md#support-level) [![Release Version](https://img.shields.io/github/release/10up/wpcs-action.svg)](https://github.com/10up/wpcs-action/releases/latest) [![MIT License](https://img.shields.io/github/license/10up/wpcs-action.svg)](https://github.com/10up/wpcs-action/blob/develop/LICENSE)

This action will run PHPCS ([PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)) against [WordPress Coding Standards](https://github.com/WordPress/WordPress-Coding-Standards) and show warnings and errors as annotations in your PRs without adding PHPCS as a dependency or a PHP CodeSniffer config.

### [Automating PR operations](https://github.com/10up/action-pr-automator)

[![Support Level](https://img.shields.io/badge/support-beta-blueviolet.svg)](#support-level) [![Release Version](https://img.shields.io/github/release/10up/action-pr-automator.svg)](https://github.com/10up/action-pr-automator/releases/latest) [![License](https://img.shields.io/github/license/10up/action-pr-automator.svg)](https://github.com/10up/action-pr-automator/blob/develop/LICENSE.md) [![CodeQL](https://github.com/10up/action-pr-automator/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/10up/action-pr-automator/actions/workflows/codeql-analysis.yml)

This action automates some common PR operations like validating PR description, changlog, and credits.
- **Validate PR description:** It validates PR description to make sure it contains description of the change, changelog and credits. Also, you can set custom comment message for PR author to inform them about PR description requirements.
- **Add Labels:** It helps with adding label to PR when PR validation pass or fail.
- **Auto-assign PR:** It helps with assigning PR to the author.
- **Auto request review:** It helps with request review from the team or GitHub user given in the configuration.

### [Publishing generated hook documentation to GitHub Pages](hookdocs-workflow.md)

If you follow the [JSDoc](https://jsdoc.app/) standard for your custom WordPress actions and filters, you can use this workflow to generate documentation for your theme/plugin and publish them to GitHub Pages. For an example of the output, see the [Distributor hook docs](https://10up.github.io/distributor/). The [linting workflow](https://github.com/10up/maps-block-apple/blob/develop/.github/workflows/linting.yml) of Block for Apple Maps is a good example how to use this action in practice.

### [Using markdown content in GitHub Actions summary](using-markdown-in-action-summary.md)

In May 2022, GitHub introduced the [markdown support](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/) for the GitHub Actions summaries. This feature can help improve the developer experience by generating more useful reports to action summaries.

## Planned

* Building a production-ready version into a `stable` branch or other location of choice.

## Contributing

Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

## Support Level

**Active:** 10up is actively working on this, and we expect to continue work for the foreseeable future including keeping tested up to the most recent version of WordPress.  Bug reports, feature requests, questions, and pull requests are welcome.

## Like what you see?

<p align="center">
<a href="http://10up.com/contact/"><img src="https://10up.com/uploads/2016/10/10up-Github-Banner.png" width="850"></a>
</p>
