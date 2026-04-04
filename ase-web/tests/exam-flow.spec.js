const { test, expect } = require('@playwright/test');

test('User can navigate to A1 Practice Mode', async ({ page }) => {
  // 1. Give the overall test 60 seconds to run
  test.setTimeout(60000);

  // 2. Go to the home page
  await page.goto('http://127.0.0.1:3000');

  // 3. Verify the page loaded
  await expect(page.locator('h1').first()).toContainText('ASE Practice Platform', { timeout: 15000 });

  // 4. Click on the A1 Exam card to expand the accordion
  await page.getByText('Engine Repair').click();

  // 5. Click the Practice button
  await page.getByRole('link', { name: 'Start Practice Mode' }).first().click();

  // 6. Verify the URL changed (Give Next.js up to 30 seconds to compile the new page!)
  await expect(page).toHaveURL(/.*\/test\/A1.*/, { timeout: 30000 });
  
  // 7. Verify the test page actually rendered
  await expect(page.locator('h1').first()).toContainText('A1', { timeout: 30000 });
});