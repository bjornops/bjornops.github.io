# bjornops.github.io

## Usage
Run locally at pwd:

```bash
docker run -p 8080:4000 -v $(pwd):/site bretfisher/jekyll-serve
```

Optional add `-e JEKYLL_ENV=production`

To run with local Matomo tracking, use the following command after running Matomo as described below.

```bash
docker run -p 80:4000 -e JEKYLL_ENV=production -v $(pwd):/site bretfisher/jekyll-serve bundle exec jekyll serve --force_polling --config _config.yml,_config_dev.yml -H 0.0.0.0 -P 4000
```

## Matomo Tracking

To run matomo locally, `cd matomo` and `docker compose up`.

## Minimal Mistakes remote theme starter

Click [**Use this template**](https://github.com/mmistakes/mm-github-pages-starter/generate) button above for the quickest method of getting started with the [Minimal Mistakes Jekyll theme](https://github.com/mmistakes/minimal-mistakes).

Contains basic configuration to get you a site with:

- Sample posts.
- Sample top navigation.
- Sample author sidebar with social links.
- Sample footer links.
- Paginated home page.
- Archive pages for posts grouped by year, category, and tag.
- Sample about page.
- Sample 404 page.
- Site wide search.

Replace sample content with your own and [configure as necessary](https://mmistakes.github.io/minimal-mistakes/docs/configuration/).

---

## Troubleshooting

If you have a question about using Jekyll, start a discussion on the [Jekyll Forum](https://talk.jekyllrb.com/) or [StackOverflow](https://stackoverflow.com/questions/tagged/jekyll). Other resources:

- [Ruby 101](https://jekyllrb.com/docs/ruby-101/)
- [Setting up a Jekyll site with GitHub Pages](https://jekyllrb.com/docs/github-pages/)
- [Configuring GitHub Metadata](https://github.com/jekyll/github-metadata/blob/master/docs/configuration.md#configuration) to work properly when developing locally and avoid `No GitHub API authentication could be found. Some fields may be missing or have incorrect data.` warnings.
