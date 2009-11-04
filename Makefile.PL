use inc::Module::Install;
name 'Pod-HTMLEmbed';
all_from 'lib/Pod/HTMLEmbed.pm';

test_requires 'Test::More';
use_test_base;
author_tests('xt');

auto_include;
auto_set_repository;

WriteAll;
