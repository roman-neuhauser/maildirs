// Copyright (c) 2009 Roman Neuhauser
// Distributed under the MIT license (see LICENSE file)
// vim: sw=4 sts=4 et fdm=marker cms=\ //\ %s

#include <iostream>
#include <string>
#include <utility>
#include <boost/filesystem.hpp>
#include <boost/foreach.hpp>

namespace fs = boost::filesystem;

bool
is_maildir(fs::path const & p)
{
    return is_directory(p)
        && is_directory(p / "cur")
        && is_directory(p / "new")
        && is_directory(p / "tmp")
    ;
}

void
usage(std::string const & self)
{
    std::cerr
        << self + " dir [sep]"
        << std::endl
    ;
}

int
main(int argc, char ** argv)
{
    if (1 > argc) {
        return 3;
    }
    if (2 > argc || 3 < argc) {
        usage(argv[0]);
        return 2;
    }
    if (!fs::is_directory(argv[1])) {
        usage(argv[0]);
        return 1;
    }

    fs::path top(argv[1]);
    std::string sep(" ");

    if (2 < argc) sep = argv[2];
    if ("\\n" == sep) sep = "\n";

    fs::recursive_directory_iterator it(top), eod;
    BOOST_FOREACH(fs::path const & p, std::make_pair(it, eod)) {
        if (is_maildir(p)) {
            std::cout << p << sep;
            it.no_push();
        }
    }
    return 0;
}

