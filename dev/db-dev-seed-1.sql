insert into todo_list (todo_list_name, todo_list_description) values
  ('Project: janet-htmx-project-template', 'Things I need to do to wrap up this git repository.');

----------

insert into todo_list_item (todo_list_id, todo_list_item_text, todo_list_item_checked) values
  (1, 'Drink more coffee.', 1),
  (1, 'Add login feature.', 0),
  (1, 'Prevent XSS scripting stuff.', 0),
  (1, 'Deploy.', 0),
  (1, 'Go viral on Hacker News.', 0),
  (1, 'Read Github issues for this repo.', 0),
  (1, 'Tell creators of Github issues that real OGs are on Sourcehut.', 0);
