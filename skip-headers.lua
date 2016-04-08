function string.starts(haystack,  needle)
  return haystack:sub(1, needle:len()) == needle
end

core.register_action('skip-headers', { "tcp-req" }, function(txn)
  local line = txn.req:getline();

  txn:Info("connect-ssh");

  if line == nil then
    txn:Debug("Got nil, skipping...");
    return
  elseif not line:starts("CONNECT 127.0.0.1:22 HTTP/1.1") then
    txn:Debug("No match, got " .. line .. ", skipping...");
    return
  end

  repeat -- skip headers
    txn:Debug(line);
    line = txn.req:getline();
  until line == nil or line == "" or line == "\n";

end);
