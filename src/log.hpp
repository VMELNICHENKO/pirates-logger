#pragma once
#include <iostream>
#include <stdlib.h>
//#include <chrono>
#include <stdio.h>
#include <fcntl.h>
#include <panda/string_view.h>
#include <panda/event/FSRequest.h>

using xs::XSBackref;
using namespace std;
using panda::string;
using namespace panda::event;
using panda::iptr;

class Logger : public XSBackref {
 public:
    iptr<FSRequest> fsRequest;
    uint64_t _pos = 0;
    file_t log_file;
    Loop* loop;
    Logger(Loop* l){ loop = l;};
    ~Logger(){
        cout << " DTOR" << endl;
    };
};
