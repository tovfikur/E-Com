from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.permissions import AllowAny
from ..models import (
    Cart, CartItem, CartDiscount, CartSharing, CartSaveForLater)
from .serializers import (
    CartSerializer, CartItemsSerializer, CartDiscountsSerializer,
    CartSharingSerializer, CartSaveForLaterSerializer
)

# Define viewsets for each model
class CartViewSet(viewsets.ModelViewSet):

    queryset = Cart.objects.all()
    serializer_class = CartSerializer
    permission_classes = [AllowAny]

    def get_queryset(self):
        if self.request.user.is_authenticated:
            # Return carts associated with the logged-in user
            return Cart.objects.filter(user=self.request.user)
        else:
            # Return carts associated with the current session
            session_key = self.request.session.session_key
            if not session_key:
                self.request.session.create()
                session_key = self.request.session.session_key
            return Cart.objects.filter(session_key=session_key)


    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        cart = serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class CartItemsViewSet(viewsets.ModelViewSet):
    queryset = CartItem.objects.all()
    serializer_class = CartItemsSerializer
 
class CartDiscountsViewSet(viewsets.ModelViewSet):
    queryset = CartDiscount.objects.all()
    serializer_class = CartDiscountsSerializer

class CartSharingViewSet(viewsets.ModelViewSet):
    queryset = CartSharing.objects.all()
    serializer_class = CartSharingSerializer

class CartSaveForLaterViewSet(viewsets.ModelViewSet):
    queryset = CartSaveForLater.objects.all()
    serializer_class = CartSaveForLaterSerializer