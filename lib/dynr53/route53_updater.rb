class Route53Updater
	def initialize(zone, access_key, secret_key)
		@zone = zone
		@access_key = access_key
		@secret_key = secret_key

		AWS.config(access_key_id: @access_key, secret_access_key: @secret_key, region: 'us-east-1')
		@r53 = AWS::Route53.new
	end

	def update_host(host, new_ip)
		updater = Updater.new(@r53.client, @zone)
		updater.change_record(host, new_ip)
	end
end