if Rails.env.development?
  role_reader = Role.create! name: 'reader'
  role_writer = Role.create! name: 'writer'
  role_admin = Role.create! name: 'admin'

  reader = User.create! email: 'reader@mail.com', password: '123123123', roles: [role_reader]
  writer = User.create! email: 'writer@mail.com', password: '123123123', roles: [role_writer]
  admin = User.create! email: 'admin@mail.com', password: '123123123', roles: [role_admin]

  Post.create! title: 'post1', body: 'post1', author: writer
  Post.create! title: 'post2', body: 'post2', author: writer
  Post.create! title: 'post3', body: 'post3', author: writer
  Post.create! title: 'post4', body: 'post4', author: writer
  Post.create! title: 'post5', body: 'post5', author: admin
  Post.create! title: 'post6', body: 'post5', author: admin
  Post.create! title: 'post7', body: 'post5', author: admin
end