# PowerShell script to test all API endpoints
$baseUrl = "http://localhost:8000/api"
$token = ""

Write-Host "🔍 Starting API Tests..." -ForegroundColor Cyan

# Function to make curl requests
function Invoke-ApiRequest {
    param (
        [string]$method,
        [string]$endpoint,
        [string]$body = "",
        [string]$auth = ""
    )
    
    $headers = @{
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    if ($auth) {
        $headers["Authorization"] = "Bearer $auth"
    }
    
    $params = @{
        Method = $method
        Uri = "$baseUrl$endpoint"
        Headers = $headers
    }
    
    if ($body) {
        $params["Body"] = $body
    }
    
    try {
        $response = Invoke-RestMethod @params
        return $response
    }
    catch {
        Write-Host "❌ Error for $method $endpoint" -ForegroundColor Red
        Write-Host $_.Exception.Message
        return $null
    }
}

# 1. Testing Authentication Endpoints
Write-Host "`n📍 Testing Authentication Endpoints..." -ForegroundColor Yellow

# Register
$registerBody = @{
    name = "Test User"
    email = "test@example.com"
    password = "password123"
    password_confirmation = "password123"
} | ConvertTo-Json

Write-Host "`nTesting Register..."
$registerResponse = Invoke-ApiRequest -method "POST" -endpoint "/register" -body $registerBody

# Login
$loginBody = @{
    email = "test@example.com"
    password = "password123"
} | ConvertTo-Json

Write-Host "`nTesting Login..."
$loginResponse = Invoke-ApiRequest -method "POST" -endpoint "/login" -body $loginBody
if ($loginResponse.token) {
    $token = $loginResponse.token
    Write-Host "✅ Login successful" -ForegroundColor Green
}

# Verify OTP (if needed)
$otpBody = @{
    email = "test@example.com"
    otp = "123456"
} | ConvertTo-Json

Write-Host "`nTesting OTP Verification..."
$otpResponse = Invoke-ApiRequest -method "POST" -endpoint "/verify-otp" -body $otpBody

# 2. Testing Shop Management (Owner endpoints)
Write-Host "`n📍 Testing Shop Management Endpoints..." -ForegroundColor Yellow

# Create Shop
$shopBody = @{
    name = "Test Barber Shop"
    address = "123 Test Street"
    description = "A test barber shop"
    latitude = 40.7128
    longitude = -74.0060
} | ConvertTo-Json

Write-Host "`nTesting Shop Creation..."
$createShopResponse = Invoke-ApiRequest -method "POST" -endpoint "/shops" -body $shopBody -auth $token
$shopId = $createShopResponse.shop.id

# Get Shop
Write-Host "`nTesting Get Shop..."
$getShopResponse = Invoke-ApiRequest -method "GET" -endpoint "/shops/$shopId" -auth $token

# Update Shop
$updateShopBody = @{
    name = "Updated Shop Name"
    description = "Updated description"
} | ConvertTo-Json

Write-Host "`nTesting Shop Update..."
$updateShopResponse = Invoke-ApiRequest -method "PUT" -endpoint "/shops/$shopId" -body $updateShopBody -auth $token

# 3. Testing Shop Members
Write-Host "`n📍 Testing Shop Members Endpoints..." -ForegroundColor Yellow

# Add Member
$memberBody = @{
    name = "Test Member"
    email = "member@example.com"
    role = "barber"
} | ConvertTo-Json

Write-Host "`nTesting Add Member..."
$addMemberResponse = Invoke-ApiRequest -method "POST" -endpoint "/shops/$shopId/members" -body $memberBody -auth $token
$memberId = $addMemberResponse.member.id

# Get Members
Write-Host "`nTesting Get Members..."
$getMembersResponse = Invoke-ApiRequest -method "GET" -endpoint "/shops/$shopId/members" -auth $token

# 4. Testing Bookings
Write-Host "`n📍 Testing Booking Endpoints..." -ForegroundColor Yellow

# Create Booking
$bookingBody = @{
    member_id = $memberId
    date = (Get-Date).AddDays(1).ToString("yyyy-MM-dd")
    time = "10:00:00"
    duration = 30
} | ConvertTo-Json

Write-Host "`nTesting Create Booking..."
$createBookingResponse = Invoke-ApiRequest -method "POST" -endpoint "/shops/$shopId/bookings" -body $bookingBody -auth $token
$bookingId = $createBookingResponse.booking.id

# Get Bookings
Write-Host "`nTesting Get Bookings..."
$getBookingsResponse = Invoke-ApiRequest -method "GET" -endpoint "/shops/$shopId/bookings" -auth $token

# Logout
Write-Host "`n📍 Testing Logout..." -ForegroundColor Yellow
$logoutResponse = Invoke-ApiRequest -method "POST" -endpoint "/logout" -auth $token

Write-Host "`n✨ API Testing Complete!" -ForegroundColor Green
