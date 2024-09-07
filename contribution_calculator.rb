require 'csv'

def calculate_contributions(transactions, target_redemption, target_store)
  remaining_to_redeem = target_redemption
  final_contributions = {}

  transactions.each do |transaction|
    store = transaction['Store']
    collected = transaction['Collected'].to_i

    next if store == target_store
    
    if remaining_to_redeem > 0
      contribution = [collected, remaining_to_redeem].min

      final_contributions[store] ||= 0
      final_contributions[store] += contribution

      remaining_to_redeem -= contribution

      puts "Store: #{store}, Contributing: #{contribution}, Remaining to redeem: #{remaining_to_redeem}"
    end

    break if remaining_to_redeem <= 0
  end

  final_contributions
end

# Read transactions from CSV file
transactions = CSV.read('mtsb-interview.csv', headers: true)

# Filter transactions by phone number
phone_number = '60128846458'
filtered_transactions = transactions.select { |transaction| transaction['Phone'] == phone_number }

# Target redemption
target_redemption = 500
target_store = 'Alpha Sdn Bhd'

# Calculate contributions dynamically in FIFO manner
final_contributions = calculate_contributions(filtered_transactions, target_redemption, target_store)

# Output the result
puts "Final contributions (FIFO):"
final_contributions.each do |store, amount|
  puts "#{store} contributes #{amount} to #{target_store}"
end
