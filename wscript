import os
import Options
import Utils

srcdir = '.'
blddir = 'build'
VERSION = '0.0.1'

def set_options(opt):
  opt.tool_options('compiler_cxx')
  
  opt.add_option( '--includes'
                , action='store'
                , default=os.getenv("CPATH")
                , help='Custom directories containing snappy header files [default: $CPATH]'
                , dest='includes'
                )

  opt.add_option( '--libpath'
                , action='store'
                , default=os.getenv("LD_LIBRARY_PATH")
                , help='Custom directories to search for the shared V8 [default: $LD_LIBRARY_PATH]'
                , dest='libpath'
                )

def configure(conf):
  conf.check_tool('compiler_cxx')
  conf.check_tool('node_addon')

  if isinstance(Options.options.libpath, str):
    for libpath in Options.options.libpath.partition(':'):
      conf.env.append_value("LIBPATH_SNAPPY", libpath)

  if isinstance(Options.options.includes, str):
    for includes in Options.options.includes.partition(':'):
      conf.env.append_value("CPPPATH_SNAPPY", includes)

  conf.env.append_value("LIB_SNAPPY", "snappy")

def build(bld):
  obj = bld.new_task_gen('cxx', 'shlib', 'node_addon')
  obj.uselib = "SNAPPY"
  # -D_FILE_OFFSET_BITS and -D_LARGEFILE_SOURCE needed for libeio
  obj.cxxflags = ['-Wall', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE']
  obj.target = 'binding'
  obj.source = 'binding.cc'
  obj.install_path = None
  
  Utils.exec_command('cake compile')

def test(tsk):
  Utils.exec_command('vows test.coffee --spec')
