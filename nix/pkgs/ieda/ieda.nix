{
  lib,
  stdenv,
  cmake,
  ninja,
  flex,
  bison,
  zlib,
  tcl,
  boost,
  eigen,
  yaml-cpp,
  libunwind,
  glog-lock,
  gtest,
  gflags,
  metis,
  gmp,
  python3,
  onnxruntime,
  iir-rust,
  sdf-parse,
  spef-parser,
  vcd-parser,
  verilog-parser,
  liberty-parser,
  gperftools,
  iedaSrc,
}:

stdenv.mkDerivation {
  pname = "ieda";
  version = "0.1.0";

  src = iedaSrc;

  nativeBuildInputs = [
    cmake
    ninja
    flex
    bison
    python3
    tcl
  ];

  cmakeBuildType = "Release";

  cmakeFlags = [
    (lib.cmakeBool "CMD_BUILD" true)
    (lib.cmakeBool "SANITIZER" false)
    (lib.cmakeBool "BUILD_STATIC_LIB" false)
    (lib.cmakeBool "USE_PROFILER" false)
  ];

  preConfigure = ''
    cmakeFlags+=" -DCMAKE_RUNTIME_OUTPUT_DIRECTORY:FILEPATH=$out/bin -DCMAKE_LIBRARY_OUTPUT_DIRECTORY:FILEPATH=$out/lib"
  '';

  buildInputs = [
    iir-rust
    sdf-parse
    spef-parser
    vcd-parser
    verilog-parser
    liberty-parser
    gtest
    glog-lock
    gflags
    boost
    onnxruntime
    eigen
    yaml-cpp
    libunwind
    metis
    gmp
    tcl
    zlib
    gperftools
  ];

  postInstall = ''
    # Tests rely on hardcoded path, so they should not be included
    rm $out/bin/*test $out/bin/*Test $out/bin/test_* $out/bin/*_app
  '';

  enableParallelBuild = true;

  meta = {
    description = "Open-source EDA infracstructure and tools from Netlist to GDS for ASIC design";
    homepage = "https://gitee.com/oscc-project/iEDA";
    license = lib.licenses.mulan-psl2;
    mainProgram = "iEDA";
    platforms = lib.platforms.linux;
  };
}
