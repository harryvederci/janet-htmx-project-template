insert into todo_list (todo_list__name, todo_list__description) values
  ('Project: janet-htmx-project-template', 'Things I need to do to wrap up this git repository.');

----------

insert into todo_list_item (todo_list__id, todo_list_item__text, todo_list_item__checked) values
  (1, 'Drink more coffee.', 1),
  (1, 'Add login feature.', 0),
  (1, 'Prevent XSS scripting stuff.', 0),
  (1, 'Deploy.', 0),
  (1, 'Go viral on Hacker News.', 0),
  (1, 'Read Github issues for this repo.', 0),
  (1, 'Tell creators of Github issues that real OGs are on Sourcehut.', 0);

----------

insert into user (user__email_address, user__password) values
  ('mail@example.com', '01f04d9f364dc06dcf0428c90f17fd333f568dc7f95437485d6844f1f3d090b52e80bc9637de741b6a05f5de51b8e0d71fa8c0dc76749e25cd2271b19234d7951df738191e507b75880db1e05e3caaa08fdabc6ff7aaaa8b36682ecaaeddbdba184752a933106900000000000000000000000000000000000000000000000000');
