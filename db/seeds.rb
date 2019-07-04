User.create!(name: "Seiya_waka",
             field: "せいや",
             email: "e1517234@soka-u.jp",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name: "Yoto_waka",
             field: "ゆうと",
             email: "wakabadmt@soka-u.jp",
             password: "foobaz",
             password_confirmation: "foobaz",
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name: "Yuta_waka",
             field: "ゆうた",
             email: "wakaba@soka-u.jp",
             password: "reaction",
             password_confirmation: "reaction",
             activated: true,
             activated_at: Time.zone.now)
             
             
Genre.create([
          { name: "SF"},
          { name: "異世界ファンタジー"},
          { name: "現代ファンタジー"},
          { name: "恋愛"},
          { name: "ホラー"},
          { name: "ミステリー"},
          { name: "サスペンス"},
          { name: "エッセイ・ノンフィクション"},
          { name: "歴史・時代・伝奇"},
          { name: "その他"}
          ])
          
Tag.create([
        { name: "連載中" },
        { name: "完結" }
  ])