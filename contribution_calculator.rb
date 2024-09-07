def calculate_contributions(transactions, target_redemption, target_store)
  remaining_to_redeem = target_redemption
  final_contributions = {}

  transactions.each do |transaction|
    store = transaction[:store]
    collected = transaction[:collected]

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

# Example transactions
transactions = [
  { date: '05/01/2020', phone: '60121224273', store: 'Foxtrot Sdn Bhd', collected: 157, redeemed: 0 },
  { date: '15/01/2020', phone: '60121224273', store: 'Charlie Sdn Bhd', collected: 47, redeemed: 0 },
  { date: '17/01/2020', phone: '60121224273', store: 'Foxtrot Sdn Bhd', collected: 121, redeemed: 0 },
  { date: '20/01/2020', phone: '60121224273', store: 'Foxtrot Sdn Bhd', collected: 153, redeemed: 0 },
  { date: '29/09/2020', phone: '60121224273', store: 'Alpha Sdn Bhd', collected: 51, redeemed: 250 }
]

# Target redemption
target_redemption = 250
target_store = 'Alpha Sdn Bhd'

# Step 2: Calculate contributions dynamically in FIFO manner
final_contributions = calculate_contributions(transactions, target_redemption, target_store)

# Step 3: Output the result
puts "Final contributions (FIFO):"
final_contributions.each do |store, amount|
  puts "#{store} contributes #{amount}"
end
