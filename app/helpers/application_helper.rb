module ApplicationHelper
  def default_meta_tags(title, description)
    if description.present?
      description = "【暗記くん】#{description}"
    else
      description = "【暗記くん】の#{title}ページです。暗記したい内容を登録して、暗記くんが通知してくれたタイミングで復習するだけで、簡単に暗記できます。"
    end

    {
        site: '暗記くん',
        title: title,
        reverse: true,
        charset: 'utf-8',
        description: description,
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
