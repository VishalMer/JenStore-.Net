$(document).ready(function() {
    // Handle form submission
    $('#editProfileForm').on('submit', function(e) {
        e.preventDefault();
        
        // Hide any existing messages
        $('.success-message, .error-message').hide();
        
        // Get form data
        var formData = {
            username: $('#username').val(),
            email: $('#email').val(),
            gender: $('#gender').val(),
            currentPassword: $('#currentPassword').val()
        };
        
        // Basic validation
        if (!formData.username || !formData.email || !formData.currentPassword) {
            showError('Please fill in all required fields.');
            return;
        }
        
        if (formData.username.length < 3) {
            showError('Username must be at least 3 characters long.');
            return;
        }
        
        if (!isValidEmail(formData.email)) {
            showError('Please enter a valid email address.');
            return;
        }
        
        // Simulate API call (replace with actual API endpoint)
        updateProfile(formData);
    });
    
    // Function to show error message
    function showError(message) {
        $('#errorText').text(message);
        $('#errorMessage').show();
        $('html, body').animate({
            scrollTop: $('#errorMessage').offset().top - 100
        }, 500);
    }
    
    // Function to show success message
    function showSuccess() {
        $('#successMessage').show();
        $('html, body').animate({
            scrollTop: $('#successMessage').offset().top - 100
        }, 500);
        
        // Clear password field
        $('#currentPassword').val('');
        
        // Redirect to dashboard after 2 seconds
        setTimeout(function() {
            window.location.href = 'user-dashboard.html';
        }, 2000);
    }
    
    // Function to validate email format
    function isValidEmail(email) {
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
    
    // Function to update profile (simulate API call)
    function updateProfile(data) {
        // Show loading state
        $('.btn-update').html('<i class="fas fa-spinner fa-spin"></i> Updating...');
        $('.btn-update').prop('disabled', true);
        
        // Simulate API delay
        setTimeout(function() {
            // Simulate success (replace with actual API response handling)
            if (data.currentPassword === 'password123') { // Demo password
                showSuccess();
            } else {
                showError('Current password is incorrect. Please try again.');
                $('.btn-update').html('<i class="fas fa-save"></i> Update Profile');
                $('.btn-update').prop('disabled', false);
            }
        }, 1500);
    }
    
    // Clear messages when user starts typing
    $('input, select').on('input change', function() {
        $('.success-message, .error-message').hide();
    });
    
    // Add loading animation to buttons
    $('.btn-update, .btn-cancel').on('click', function() {
        if ($(this).hasClass('btn-update')) {
            $(this).addClass('loading');
        }
    });
    
    // Handle cancel button
    //$('.btn-cancel').on('click', function() {
    //    if (confirm('Are you sure you want to cancel? Any unsaved changes will be lost.')) {
    //        window.location.href = 'user-dashboard.html';
    //    }
    //});
});
