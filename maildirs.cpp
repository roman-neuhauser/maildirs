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

int
main(int argc, char ** argv)
{
    using std::cout;
    using std::cerr;
    using std::endl;

    if (1 > argc) {
        return 3;
    }
    if (2 > argc || 3 < argc) {
        cerr
            << std::string(argv[0]) + " dir [sep]"
            << endl
        ;
        return 2;
    }

    fs::path top(argv[1]);
    std::string sep(" ");

    if (2 < argc) sep = argv[2];
    if ("\\n" == sep) sep = "\n";

    if (!is_directory(top)) {
        return 1;
    }

    fs::recursive_directory_iterator it(top), eod;
    BOOST_FOREACH(fs::path const & p, std::make_pair(it, eod)) {
        if (is_maildir(p)) {
            cout << p << sep;
            it.no_push();
        }
    }
    return 0;
}

