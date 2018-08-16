# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Class to stub Chef::Mixin::ShellOut#shell_out result.
class FakeShellOut
  # Class to stub Chef::Mixin::ShellOut#shell_out status result.
  class FakeShellOutStatus
    def initialize(status)
      @status = status
    end
  end

  attr_reader :status, :stdout

  def initialize
    and_return_status(true)
    and_return_stdout('')
  end

  def and_return_status(status)
    @status = FakeShellOutStatus.new(status)
    self
  end

  def and_return_stdout(stdout)
    @stdout = stdout
    self
  end
end

def stub_shell_out(cmd)
  output = FakeShellOut.new
  allow_any_instance_of(Chef::Mixin::ShellOut).to receive(:shell_out)
    .with(cmd)
    .and_return(output)
  output
end

def data_file(file)
  data_dir = ::File.join(::File.dirname(__FILE__), '..', 'data')
  ::IO.read(::File.join(data_dir, file))
end
