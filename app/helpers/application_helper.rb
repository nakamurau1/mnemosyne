module ApplicationHelper
  # ページごとの完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "暗記くん"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def default_meta_tags
    {
        site: '暗記くん',
        title: '暗記くん',
        reverse: true,
        charset: 'utf-8',
        description: 'ソフトウェアのように知識をインストールする',
        keywords: '暗記,記憶,Anki,語学,元素記号,百人一首,テスト,試験,考査',
        canonical: request.original_url,
        separator: '|',
        #icon: [
        #    { href: image_url('favicon.ico') },
        #    { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
        #],
        og: {
            site_name: :site, # もしくは site_name: :site
            title: :title, # もしくは title: :title
            description: :description, # もしくは description: :description
            type: 'website',
            url: request.original_url,
            # image: image_url('ogp.png'),
            locale: 'ja_JP',
        },
        twitter: {
            card: 'summary',
            site: '@ツイッターのアカウント名',
        }
    }
  end
end
