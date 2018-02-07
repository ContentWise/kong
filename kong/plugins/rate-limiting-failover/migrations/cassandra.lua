return {
  {
    name = "2015-08-03-132400_init_ratelimitingfailover",
    up = [[
      CREATE TABLE IF NOT EXISTS ratelimiting_failover_metrics(
        api_id uuid,
        identifier text,
        period text,
        period_date timestamp,
        value counter,
        PRIMARY KEY ((api_id, identifier, period_date, period))
      );
    ]],
    down = [[
      DROP TABLE ratelimiting_failover_metrics;
    ]]
  },
  {
    name = "2016-07-25-471385_ratelimitingfailover_policies",
    up = function(_, _, dao)
      local rows, err = dao.plugins:find_all {name = "rate-limiting-failover"}
      if err then
        return err
      end

      for i = 1, #rows do
        local rate_limiting_failover = rows[i]

        -- Delete the old one to avoid conflicts when inserting the new one
        local _, err = dao.plugins:delete(rate_limiting_failover)
        if err then
          return err
        end

        local _, err = dao.plugins:insert {
          name = "rate-limiting",
          api_id = rate_limiting_failover.api_id,
          consumer_id = rate_limiting_failover.consumer_id,
          enabled = rate_limiting_failover.enabled,
          config = {
            second = rate_limiting_failover.config.second,
            minute = rate_limiting_failover.config.minute,
            hour = rate_limiting_failover.config.hour,
            day = rate_limiting_failover.config.day,
            month = rate_limiting_failover.config.month,
            year = rate_limiting_failover.config.year,
            limit_by = "consumer",
            policy = "cluster",
            fault_tolerant = rate_limiting_failover.config.continue_on_error
          }
        }
        if err then
          return err
        end
      end
    end
  }
}
