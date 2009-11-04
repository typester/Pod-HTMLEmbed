use inc::Module::Install;
name 'Pod-HTMLEmbed';
all_from 'lib/Pod/HTMLEmbed.pm';

requires 'Any::Moose' => '0.10';

test_requires 'Test::More' => '0.88';
author_tests('xt');

auto_include;
auto_set_repository;

WriteAll;
