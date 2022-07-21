class Firtool < Formula
  desc "Firtool is the CIRCT FIRRTL to Verilog compiler"
  homepage "https://circt.llvm.org/"
  license "Apache-2.0"
  url "https://github.com/llvm/circt.git",
    tag:      "sifive/1/10/0",
    revision: "275e45fd8e671e2f09408a460a910a890808acd0"
  version "1.10.0"

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    llvmpath = buildpath/"llvm"

    mkdir llvmpath/"build" do
      args = std_cmake_args
      args << "-DLLVM_ENABLE_PROJECTS=\"mlir\""
      args << "-DLLVM_TARGETS_TO_BUILD=\"host\""
      args << "-DLLVM_ENABLE_ASSERTIONS=OFF"
      args << "-DLLVM_ENABLE_TERMINFO=OFF"
      args << "-DLLVM_STATIC_LINK_CXX_STDLIB=ON"
      args << "-DLLVM_BUILD_EXAMPLES=OFF"
      args << "-DLLVM_ENABLE_ASSERTIONS=OFF"
      args << "-DLLVM_ENABLE_BINDINGS=OFF"
      args << "-DLLVM_ENABLE_OCAMLDOC=OFF"
      args << "-DLLVM_OPTIMIZED_TABLEGEN=ON"
      args << "../llvm"
      system "cmake", "-G", "Ninja", *args
      system "ninja"
    end

    mkdir buildpath/"build" do
      args = std_cmake_args
      args << "-DMLIR_DIR=" + buildpath + "llvm/build/lib/cmake/mlir"
      args << "-DLLVM_DIR=" + buildpath + "llvm/build/lib/cmake/llvm"
      args << "-DLLVM_ENABLE_ASSERTIONS=OFF"
      args << "-DLLVM_STATIC_LINK_CXX_STDLIB=ON"
      args << "-DVERILATOR_DISABLE=ON"
      args << "-DLLVM_ENABLE_TERMINFO=OFF"
      system "cmake", "-G", "Ninja", *args
      system "ninja"
    end

    bin.install buildpath/"build/bin/firtool"
  end
end
