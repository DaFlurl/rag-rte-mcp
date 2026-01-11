# Game Mechanics and Limitations Documentation

## 32-bit Integer Limits
- Maximum Value: 2,147,483,647 (0x7FFFFFFF)
- Minimum Value: -2,147,483,648 (0x80000000)
- Safe Troop Limit: 700,000,000
- Valley Threshold: 1,800,000,000

## Troop Mechanics

### Safe Troop Operations
- Keep individual troop types under 700M per city
- Split large movements into multiple operations
- Allow cooldown between splits (5-10 minutes)

### Valley Operations
1. Closest Valley Method
   - Use nearest valley to minimize march time
   - Keep total troops under 1.8B to prevent overflow
   - Consider march speed multipliers

2. Thunder Raid Mechanics
   - Base troop count: 700M (safe limit)
   - Maximum effective: 1B (risky)
   - Multiplication factor: 3x
   - Warning: Exceeding 700M risks negative overflow

## City Management

### Troop Balance
- Monitor individual troop type counts
- Keep reserve troops in supporting cities
- Use safe transfer amounts (under 700M)

### Recovery Operations
1. Negative Troop Recovery
   - Transfer troops in safe batches (700M max)
   - Use multiple source cities if needed
   - Wait between transfers (5-10 minutes)

2. City Lock Prevention
   - Monitor total troop counts
   - Keep backup forces in support cities
   - Use safe withdrawal amounts

## Resource Management

### Food Consumption
- Base rate varies by troop type
- Multiplication effects apply
- Monitor consumption limits

### Resource Limits
- Maximum: 2,147,483,647
- Safe operating range: 1,800,000,000
- Buffer recommended: 300,000,000
