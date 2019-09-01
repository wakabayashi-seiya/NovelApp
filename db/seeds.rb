user_1 = User.new(name: "Seiya_waka",
                  field: "せいや",
                  email: "e1517234@soka-u.jp",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)
user_1.skip_confirmation!
user_1.save!

user_2 = User.new(name: "Yoto_waka",
                  field: "ゆうと",
                  email: "wakabadmt@soka-u.jp",
                  password: "foobaz",
                  password_confirmation: "foobaz")
user_2.skip_confirmation!
user_2.save!

user_3 = User.new(name: "Yuta_waka",
                  field: "ゆうた",
                  email: "wakaba@soka-u.jp",
                  password: "reaction",
                  password_confirmation: "reaction")
user_3.skip_confirmation!
user_3.save!

Genre.create([
               { name: "SF" },
               { name: "異世界ファンタジー" },
               { name: "現代ファンタジー" },
               { name: "恋愛" },
               { name: "ホラー" },
               { name: "ミステリー" },
               { name: "サスペンス" },
               { name: "エッセイ・ノンフィクション" },
               { name: "歴史・時代・伝奇" },
               { name: "その他" }
             ])

Tag.create([
             { name: "連載中" },
             { name: "完結" }
           ])
