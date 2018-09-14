Структура каталогов:

├── ansible.cfg
├── hosts
├── playbook.retry
├── playbook.yml
├── roles
│   ├── common
│   │   ├── defaults
│   │   ├── files
│   │   ├── handlers
│   │   ├── meta
│   │   ├── tasks
│   │   │   └── main.yml
│   │   ├── templates
│   │   └── vars
│   └── web
│       ├── defaults
│       ├── files
│       ├── handlers
│       │   └── main.yml
│       ├── meta
│       ├── tasks
│       │   └── main.yml
│       ├── templates
│       │   └── etc
│       │       └── nginx
│       │           └── nginx.conf.j2
│       └── vars
│           └── main.yml
└── Vagrantfile
