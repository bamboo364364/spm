package com.mycompany.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.model.CartDTO;
import com.mycompany.model.MemberVO;
import com.mycompany.service.AdminService;
import com.mycompany.service.AttachService;
import com.mycompany.service.CartService;
import com.mycompany.service.MemberService;
import com.mycompany.service.ReplyService;

@Controller
@RequestMapping("/cart")
public class CartController {

	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	@Autowired
	private MemberService memberService;
	@Autowired
	private AttachService attachService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private CartService cartService;

	@PostMapping("/add")
	@ResponseBody
	public void addCartPOST(@RequestBody CartDTO dto) {
		logger.info(dto.toString());
		cartService.addCart(dto);

	}

	/* 카트페이지 */
	@GetMapping("/cartView")
	public String cartPageGET(String memberMail, HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("member");

		if (!mvo.getMemberMail().equals(memberMail)) {

			return "redirect:/";
		}

		if (cartService.getCart(memberMail) == null) {
			model.addAttribute("cartInfo", "empty");
		} else {

			model.addAttribute("cartInfo", cartService.getCart(memberMail));
		}

		return "/cart/cartView";
	}

	/* 카트삭제 */
	@PostMapping("/delete")
	public String delete(CartDTO dto) {
	logger.info("카트삭제메서드 진입");
		cartService.cartDelete(dto.getCartId());
		return "redirect:/cart/cartView?memberMail="+dto.getMemberMail();
	}
	
	/*
	 * 장바구니 수량 수정
	 * 
	 * @PostMapping("/cart/delete") public String deleteCartPOST(CartDTO cart) {
	 * 
	 * cartService.deleteCart(cart.getCartId());
	 * 
	 * return "redirect:/cart/" + cart.getMemberId();
	 * 
	 * }
	 */

}// class
