# Brandcash
  Simple ruby wrapper for Brandcash API 
## Usage

```ruby
Brandcash::Client.configure do |c|
  c.api_key = YOUR_API_KEY
end

client = Brandcash::Client.new
client.receipt('t=20200708T0941&s=1422.79&fn=9289440300653107&i=52258&fp=804544048')
```
