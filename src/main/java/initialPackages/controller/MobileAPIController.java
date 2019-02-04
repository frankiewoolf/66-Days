package initialPackages.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import initialPackages.WhitelistUser;
import initialPackages.WhitelistRepository;

@Controller    // This means that this class is a Controller
@RequestMapping(path="/mobile-api") // This means URL's start with /demo (after Application path)
public class MobileAPIController {

	@Autowired // This means to get the bean called userRepository
	// Which is auto-generated by Spring, we will use it to handle the data
	private WhitelistRepository whitelistRepository;

	@GetMapping(path="/add-email") // Map ONLY GET Requests
	public @ResponseBody String addNewUser (
			@RequestParam String email) {
		// @ResponseBody means the returned String is the response, not a view name
		// @RequestParam means it is a parameter from the GET or POST request

		WhitelistUser n = new WhitelistUser();
		n.setId(email);

		whitelistRepository.save(n);
		return "Saved";
	}

	@GetMapping(path="/all-emails")
	public @ResponseBody Iterable<WhitelistUser> getAllUsers() {
		// This returns a JSON or XML with the users
		return whitelistRepository.findAll();
	}

	@GetMapping(path = "/verify-email")
	public @ResponseBody boolean verifyEmail(@RequestParam String email){

		return whitelistRepository.existsById(email);
	}

}
