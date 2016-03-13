#
# Author:: Daniel DeLeo (<dan@kallistec.com>)
# Author:: Joshua Burt (<joshburt@shapeandshare.com>)
# Copyright:: Copyright 2008-2016, Chef Software Inc.
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

require 'chef/resource/scm'

class Chef
  class Resource
    # Implementations a git interact for us
    class JGit < Chef::Resource::Scm
      provides :jgit

      def initialize(name, run_context = nil)
        super
        @resource_name = :jgit
        @additional_remotes = Hash[]
        @uploadpack_allow_reachable_sha1_in_want = false
      end

      def additional_remotes(arg = nil)
        set_or_return(
          :additional_remotes,
          arg,
          kind_of: Hash
        )
      end

      # Introduced in git 2.5
      # uploadpack.allowReachableSHA1InWant::
      #   Allow `upload-pack` to accept a fetch request that asks for an
      #   object that is reachable from any ref tip. However, note that
      #   calculating object reachability is computationally expensive.
      #   Defaults to `false`.
      def uploadpack_allow_reachable_sha1_in_want(arg = nil)
        set_or_return(
          :uploadpack_allow_reachable_sha1_in_want,
          arg,
          kind_of: [TrueClass, FalseClass]
        )
      end

      alias branch revision
      alias reference revision

      alias repo repository
    end
  end
end