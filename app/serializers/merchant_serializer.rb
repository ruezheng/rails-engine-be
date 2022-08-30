class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name
end

# class MerchantSerializer
#   def self.format_merchants(merchants)
#     {
#       data: merchants.map dp |merchant|
#         {
#           id: merchant.id,
#           attributes: {
#             name: merchant.name
#           }
#         }
#     }
#   end
# end
