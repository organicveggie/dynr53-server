require 'aws-sdk'

class Updater
	def initialize(route53_client, zone)
		@zone = zone
		@r53 = route53_client
	end

	# Retrieves a hosted zone from Route53
	def get_hosted_zone()
		resp = @r53.get_hosted_zone(:id => @zone)
		resp[:hosted_zone]
	end

	# Attempts to retrieve an existing A record from Route53
	def get_a_record(host, hosted_zone = nil)
		hosted_zone ||= get_hosted_zone()

		start_name = "#{host}.#{hosted_zone[:name]}"

		resp = @r53.list_resource_record_sets(:hosted_zone_id => @zone, :start_record_name => start_name, :start_record_type => 'A')
		record = nil
		if resp[:resource_record_sets].length > 0
			record = resp[:resource_record_sets][0] if resp[:resource_record_sets][0][:type] == 'A'
		end
		record
	end

	def _create_batch_request(host_name, ip_addr, ttl)
		change = {
			:action => 'UPSERT', 
			:resource_record_set => {
				:name => host_name,
				:type => 'A',
				:ttl => ttl,
				:resource_records => [
					{:value => ip_addr}
				]
			}
		}
		batch = {
			:changes => [change]
		}
	end

	# Updates or Inserts an A record for the specified host. Uses the existing TTL iff the A record already exists.
	# Otherwise uses the specified TTL as the new TTL.
	def change_record(host, new_ip, ttl = 300)
		hosted_zone = get_hosted_zone()
		host_name = "#{host}.#{hosted_zone[:name]}"

		old_record = get_a_record(host, hosted_zone)
		new_ttl = old_record.nil? ? ttl : old_record[:ttl]

		batch = _create_batch_request(host_name, new_ip, new_ttl)

		@r53.change_resource_record_sets({:hosted_zone_id => @zone, :change_batch => batch})
	end
end