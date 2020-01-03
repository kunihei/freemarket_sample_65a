crumb :root do
  link "フリマ", root_path
end

crumb :mypage do
  link "マイページ", '/users/show'
end

crumb :deliver_address do
  link "発送元・お届け先住所変更", '/users/edit/deliver_address'
  parent :mypage
end

crumb :identification do
  link "本人情報の登録", '/users/edit/identification'
  parent :mypage
end

crumb :profile do
  link "プロフィール", '/users/edit/profile'
  parent :mypage
end

crumb :card do
  link "支払い方法", '/users/edit/card'
  parent :mypage
end

crumb :logout do
  link "ログアウト", '/users/edit/logout'
  parent :mypage
end

crumb :email_password do
  link "メール/パスワード", '/users/edit/email_password'
  parent :mypage
end

crumb :phone_confirm do
  link "電話番号の確認", '/users/edit/phone_confirm'
  parent :mypage
end

crumb :show do
  link "新品未使用★フェリシモ★スロウ★三角ニットストール★グリーン", '/items/show'
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).