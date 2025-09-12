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

### [Deploying WordPress sites to Pantheon](https://github.com/10up/pantheon-wp-deploy-action)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![Release Version](https://img.shields.io/github/release/10up/pantheon-wp-deploy-action.svg)](https://github.com/10up/pantheon-wp-deploy-action/releases/latest) [![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://github.com/10up/pantheon-wp-deploy-action/blob/trunk/LICENSE) [![Automated Tests](https://github.com/10up/pantheon-wp-deploy-action/actions/workflows/test.yml/badge.svg)](https://github.com/10up/pantheon-wp-deploy-action/actions/workflows/test.yml)

The code in Pantheon's git main branch is production ready (preprod and production environments only) therefore our preferred deployment workflow for GitHub + Pantheon sites is:
- Use Pantheon multidev environments for the project's lower environments (dev, staging, etc.) and create a GitHub branch with the same name as the multidev environment to automatically deploy to them
- The GitHub main branch deploys to the Pantheon's `Dev` environment but automatically promotes the code to the Pantheon `Test` environment
-- We use the Pantheon's `Test` environment as our preprod environment
- Once the changes have been tested we promote the code in the `Test` environment to `Live`

### [WordPress Scanner Action](https://github.com/10up/wp-scanner-action)

[![Support Level](https://img.shields.io/badge/support-active-green.svg)](#support-level) [![Release Version](https://img.shields.io/github/release/10up/wp-scanner-action.svg)](https://github.com/10up/wp-scanner-action/releases/latest) [![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/10up/wp-scanner-action/blob/trunk/LICENSE.md) [![Automated Tests](https://github.com/10up/wp-scanner-action/actions/workflows/tests.yml/badge.svg)](https://github.com/10up/wp-scanner-action/actions/workflows/tests.yml)

GitHub Action to perform various checks for WordPress sites (Syntax, Virus, known vulnerabilities).  This Action leverages our own [WP-CLI Vulnerability Scanner](https://github.com/10up/wpcli-vulnerability-scanner) to perform the known vulnerabilities scanning of WordPress plugins and themes. WP-CLI Vulnerability Scanner works with [WPScan](https://wpscan.com), [Patchstack](https://patchstack.com/) and [Wordfence Intelligence](https://www.wordfence.com/threat-intel/) to check reported vulnerabilities; you can choose any one of these three to use.
***Note**: Authentication is optional for the Wordfence Intelligence Vulnerability API.*

### [Automating repository operations](https://github.com/10up/action-repo-automator)

[![Support Level](https://img.shields.io/badge/support-beta-blueviolet.svg)](#support-level) [![Release Version](https://img.shields.io/github/release/10up/action-repo-automator.svg)](https://github.com/10up/action-repo-automator/releases/latest) [![License](https://img.shields.io/github/license/10up/action-repo-automator.svg)](https://github.com/10up/action-repo-automator/blob/develop/LICENSE.md) [![CodeQL](https://github.com/10up/action-repo-automator/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/10up/action-repo-automator/actions/workflows/codeql-analysis.yml)

This action automates some common repository operations, such as validating PR description, adding labels, auto-assigning issues, auto-requesting reviews on PRs, adding milestones, and many more.
- **Validate PR description:** It validates PR description to make sure it contains description of the change, changelog and credits. Also, you can set custom comment message for PR author to inform them about PR description requirements.
- **Add Labels:** It helps with adding label to PR when PR validation pass or fail.
- **Auto-assign Issues:** This feature helps to automatically assign issue with PR assignee when a linked PR is merged.
- **Auto-assign PR:** It helps with assigning PR to the author.
- **Auto request review:** It helps with request review from the team or GitHub user given in the configuration.
- **Add Milestone:** Automatically adds a Milestone to PRs. If the PR is connected to an issue with a milestone, the same milestone will be added to the PR. Otherwise, the next milestone from the available milestones will be assigned, sorted using version comparison.
- **Auto-label merge conflicts:** Automatically adds a label to PRs with merge conflicts, and once a conflict is resolved, the label is automatically removed.
- **Auto-comment merge conflicts:** Automatically adds a comment to PRs with merge conflicts to notify the PR author, and once a conflict is resolved, the comment is automatically removed.
- **Auto-Sync PR branch:** Automatically keeps the pull request branch up to date with the base branch.
- **Welcome first-time contributors:** Greet first-time contributors with a warm welcome message on their first issue or PR to the project.
- **Auto-comment on new Issues/PRs:** Automatically adds a comment to newly opened issues and PRs. This can be used to request users to provide as much context as possible or share links to your contributing guidelines, or anything else that suits your use case.

### [Publishing generated hook documentation to GitHub Pages](wp-hooks-documentor-workflow.md)

You can use this workflow to automatically generate a documentation for your WordPress plugin hooks (actions and filters) using the [WP Hooks Documentor](https://github.com/10up/wp-hooks-documentor) and publish them to GitHub Pages. For an example of the output, see the [Distributor hook docs](https://10up.github.io/distributor/).

### Validating project dependency licensing

If you publish projects that adhere to a certain license (e.g. GPLv2), then you will want to ensure any dependencies within your project adhere to a compatible license.  We've crafted a [GitHub Action workflow](https://github.com/10up/insert-special-characters/blob/develop/.github/workflows/dependency-review.yml) and [GPL-Compatible License Policy file](https://github.com/10up/.github/blob/trunk/.github/dependency-review-config.yml) that can be leveraged to ensure your projects are GPL-compatible.  Additional license policy files could be developed to ensure other licensing are valid (e.g. a MIT-Compatible License Policy file).

### [Using markdown content in GitHub Actions summary](using-markdown-in-action-summary.md)

In May 2022, GitHub introduced the [markdown support](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/) for the GitHub Actions summaries. This feature can help improve the developer experience by generating more useful reports to action summaries.

## Planned

* Building a production-ready version into a `stable` branch or other location of choice.

## Contributing

Want to help? Check out our [contributing guidelines](CONTRIBUTING.md) to get started.

## Support Level

**Active:** 10up is actively working on this, and we expect to continue work for the foreseeable future including keeping tested up to the most recent version of WordPress.  Bug reports, feature requests, questions, and pull requests are welcome.

## Like what you see?

<a href="http://10up.com/contact/"><img src="https://github.com/10up/.github/blob/trunk/profile/10up-github-banner.jpg" width="850" alt="Work with the 10up WordPress Practice at Fueled"></a>
