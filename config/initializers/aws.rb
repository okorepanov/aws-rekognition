# frozen_string_literal: true

Aws.config[:credentials] = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
Aws.config[:region] = ENV['AWS_REGION']
