#include <xs/xs.h>
//#include <xs/export.h>
#include "src/pirates-log/log.h"
#define MAX_ERR_SIZE    256

MODULE = Pirates::Log  PACKAGE = Pirates::Log

    MODULE = Pirates::Log        PACKAGE = Pirates::Log
PROTOTYPES: DISABLE

PiratesLog * PiratesLog::new( Loop* loop = Loop::default_loop() ){
  RETVAL = new PiratesLog(loop);
}

void PiratesLog::open(panda::string path, CV* cb) {
  THIS->fsRequest = new FSRequest();
  ///  THIS->fsRequest->retain();
  //  cout << "OPEN" << endl;
  SvREFCNT_inc_simple_void_NN(cb);
  THIS->fsRequest->open(path, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR, [ THIS, cb ]( FSRequest* req, const RequestError& err, file_t file ){
      if (!cb) {
	SvREFCNT_dec_NN(cb);
	return;
      }

      SV* arg1 = typemap_outcast<PiratesLog*, const char* CLASS>(THIS, "Pirates::Log");
      SV* arg2 = typemap_outcast<panda::string>(err.str());
      SV* args[] = {arg1, arg2};
      xs::call_sub_void(aTHX_ cb, args, 2);
      SvREFCNT_dec_NN(arg1);
      SvREFCNT_dec_NN(arg2);
      SvREFCNT_dec_NN(cb);
    });
}

void PiratesLog::print( panda::string buf, CV* cb ) {
  SvREFCNT_inc_simple_NN(cb);
  //  cout << "PRINT: " << buf << endl;
  ///  THIS->fsRequest->retain();
  //  cout << " REFCNT  " << THIS->refcnt() << endl;

  THIS->fsRequest->write(buf, 0, [ THIS, cb ]( FSRequest* req, const RequestError& err ){
      //      cout << "Print callback XS" << endl;
      if (!cb) {
	SvREFCNT_dec_NN(cb);
	return;
      }
      SV* arg1 = typemap_outcast<PiratesLog*, const char* CLASS>(THIS, "Pirates::Log");
      SV* arg2 = typemap_outcast<panda::string>(err.str());

      SV* args[] = {arg1,arg2};
      xs::call_sub_void(aTHX_ cb, args, 2);
      SvREFCNT_dec_NN(arg1);
      SvREFCNT_dec_NN(arg2);
      SvREFCNT_dec_NN(cb);
    });
}

void PiratesLog::loop_run() {
  //  cout << "LOOP RUN" << endl;
  Loop::default_loop()->run();
}

void PiratesLog::loop_stop() {
  //  cout << "LOOP STOP" << endl;
  Loop::default_loop()->stop();
}

void PiratesLog::DESTROY(){
  //  cout << "DESTROY  " << THIS->refcnt() << endl;
}