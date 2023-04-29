#!/usr/bin/env ruby
# Encoding: utf-8
#
# Copyright:: Copyright 2017, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# Contains an example workflow using the Accounts service.

require 'retriable'

require_relative '../shopping_common'
require_relative 'delete_account'
require_relative 'insert_account'
require_relative 'get_account'
require_relative 'list_accounts'

def account_workflow_common(content_api, merchant_id)
  puts "Getting account information for MC #{merchant_id}:"
  get_account(content_api, merchant_id, merchant_id)
  puts
end

def account_workflow_mca(content_api, merchant_id)
  puts "Listing account information for sub-accounts of MC #{merchant_id}:"
  list_accounts(content_api, merchant_id)
  puts

  info = insert_account(content_api, merchant_id)
  puts

  # The API actually returns 401 (Google::Apis::AuthorizationError) in the case
  # of retrieving or modifying not-yet fully initialized accounts. Since
  # RETRIABLE_ERRORS inside Google::Apis::Core::HttpCommand does not contain
  # Google::Apis::AuthorizationError, we can't just say:
  #   Google::Apis::RequestOptions.default.retries = 5
  #
  # However, we can use the same mechanism they use (the retriable gem).
  begin
    puts "Retrieving new MC account #{info.id}..."
    Retriable.retriable(
        tries: 5,
        on: [Google::Apis::AuthorizationError],
        on_retry: Proc.new do |ex, try, elapsed, wait|
          puts "Attempt #{try} failed, retrying in #{wait}s."
        end,
        base_interval:10 # Make the initial (average) interval 10 sec
    ) do
      get_account(content_api, merchant_id, info.id)
      puts
    end
  rescue Exception => ex # If all retries fail (or we get a different error)
    handle_errors(ex)
    puts
    return
  end

  # Since we successfully retrieved it, we should be able to delete it without
  # needing to retry.
  delete_account(content_api, merchant_id, info.id)
  puts
end

def account_workflow(content_api, config)
  puts 'Performing workflow for the Accounts service.'
  puts
  account_workflow_common(content_api, config.merchant_id)
  if config.is_mca
    account_workflow_mca(content_api, config.merchant_id)
  end
  puts 'Done with the Accounts workflow.'
end

if __FILE__ == $0
  options = ArgParser.parse(ARGV)
  config, content_api = service_setup(options)

  account_workflow(content_api, config)
end
