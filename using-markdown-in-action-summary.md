# Using Markdown in the action summary

In May 2022, GitHub introduced the [markdown support](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/) for the GitHub Actions summaries. This feature can help improve the developer experience by generating more useful reports to action summaries.

In practice, we found it's more flexible to integrate with existing workflows than to update the action itself, so the ultimate goal here is creating markdown content from the action report then outputing the content to the `$GITHUB_STEP_SUMMARY` environment variable.

This page shares our results and instruction to integrate the Job summaries feature with our frequently used workflows.

![](https://user-images.githubusercontent.com/5423135/168460231-2192571c-a873-4f23-aedb-5e469216947c.png)

## ESLint

For ESLint, we create the markdown summary from the ESLint JSON report. Because there isn't any existing tool to do that, we created [`eslint-json-to-md`](https://github.com/10up/eslint-json-to-md) command to convert the ESLint JSON to markdown content.

### Example workflow

```yml
jobs:
  eslint:
    name: eslint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: npm install
        run: npm install
      - name: Generate linting report
        run: npm run lint:js -- --output-file eslint-report.json --format json
        continue-on-error: true
      - name: Annotate code linting results
        uses: ataylorme/eslint-annotate-action@1.2.0
        with:
          repo-token: '${{ secrets.GITHUB_TOKEN }}'
          report-json: 'eslint-report.json'
      - name: Update summary
        run: |
          npm_config_yes=true npx github:10up/eslint-json-to-md --path ./eslint-report.json --output ./eslint-report.md
          cat eslint-report.md >> $GITHUB_STEP_SUMMARY
        if: ${{ failure() }}
```

### Notes

- Because this is a linting workflow, we only generate the markdown report when there are linting issues.
- ESLint config can be complex, so we use the project linting script instead of ESLint actions.

## PHPCS

Similar to ESLint, PHPCS can generate JSON reports, and we also convert that JSON report to markdown content by using [`phpcs-json-to-md`](https://github.com/10up/phpcs-json-to-md) command.

```yml
jobs:
  phpcs:
    name: WPCS
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: WPCS check
        uses: 10up/wpcs-action@stable
        with:
          use_local_config: true
          extra_args: '--report-json=./phpcs-report.json'
      - name: Update summary
        run: |
          npx github:10up/phpcs-json-to-md --path ./phpcs-report.json --output ./phpcs-report.md
          cat phpcs-report.md >> $GITHUB_STEP_SUMMARY
        if: ${{ failure() }}
```