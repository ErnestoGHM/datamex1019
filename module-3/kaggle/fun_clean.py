import pandas as pd
import matplotlib.pyplot as plt
import re
import seaborn as sns
import numpy as np
import datetime
from dateutil.relativedelta import relativedelta
def cleaning(data):
    #Property Type
    luxury = ['Treehouse','Villa','Timeshare','Castle','Tipi','Boat','Loft','Vacation home']
    low = ['Cabin','Bed & Breakfast','Yurt','Camper/RV','Hut','Tent','Hostel','Dorm']
    other = ['Guest suite','In-law','Boutique hotel','Serviced apartment','Chalet','Cave','Earth House','Train']
    data.property_type = data.property_type.apply(lambda x : 'Luxury' if x in luxury else x)\
                                               .apply(lambda x : 'Low' if x in low else x)\
                                               .apply(lambda x : 'Other' if x in other else x)
    air_prop_type = pd.get_dummies(data.property_type, drop_first=True)
    data = pd.concat([data,air_prop_type],axis = 1)
    data.drop('property_type',axis = 1,inplace = True)
    
    #Room Type
    room_v_price = data.pivot_table(index = 'room_type', values = 'price', aggfunc = 'mean')
    entire = room_v_price.loc['Entire home/apt']/room_v_price.loc['Entire home/apt']
    private = room_v_price.loc['Private room']/room_v_price.loc['Entire home/apt']
    shared = room_v_price.loc['Shared room']/room_v_price.loc['Entire home/apt']    
    data.room_type = data.room_type.apply(lambda x : entire[0] if x == 'Entire home/apt' else x)\
                                           .apply(lambda x : private[0] if x == 'Private room' else x)\
                                           .apply(lambda x : shared[0] if x == 'Shared room' else x)
    
    #Amenities
    data.amenities = data.amenities.str.replace('"translation missing: en.hosting_amenity_49"','')\
                                 .str.replace('"translation missing: en.hosting_amenity_50"','').str.split(',')
    amen = pd.DataFrame(data.amenities.apply(lambda x : len(x)))
    amen.columns = ['amenity_items']
    data = pd.concat([data,amen],axis = 1)
    data.drop('amenities',axis = 1, inplace = True)
    
    #Bed Type
    data.drop('bed_type',axis = 1, inplace = True)
    
    #Cancellation Policy
    data.cancellation_policy = data.cancellation_policy.str.replace('super_strict_30','strict')\
                                 .str.replace('super_strict_60','strict')
    air_canc_pol = pd.get_dummies(data.cancellation_policy, drop_first=True)
    data = pd.concat([data,air_canc_pol],axis = 1)
    data.drop('cancellation_policy',axis = 1,inplace = True)
    
    #Cleaning Fee
    air_clean_fee = pd.get_dummies(data.cleaning_fee, drop_first=True)
    air_clean_fee.columns = ['clean_fee']
    data = pd.concat([data,air_clean_fee],axis = 1)
    data.drop('cleaning_fee',axis = 1,inplace = True)
    
    #City
    air_city = pd.get_dummies(data.city, drop_first=True)
    data = pd.concat([data,air_city],axis = 1)
    data.drop('city',axis = 1,inplace = True)
    
    #Description
    data.drop('description',axis = 1, inplace = True)
    
    #Columnas de fechas
    data['today'] = pd.Timestamp.today()
    data['delta_first'] = (data.today - pd.to_datetime(data.first_review) )/np.timedelta64(1,'Y')
    data['delta_last'] = (data.today - pd.to_datetime(data.last_review) )/np.timedelta64(1,'Y')
    data['delta_host'] = (data.today - pd.to_datetime(data.host_since) )/np.timedelta64(1,'Y')
    data.drop(['first_review','host_since','last_review','today'],axis = 1, inplace = True)
    
    #Host Response Rate
    data.host_response_rate = data.host_response_rate.apply(lambda x : float(x.split('%')[0])/100)
    
    #Profile Pic
    data.drop('host_has_profile_pic',axis = 1, inplace = True)
    
    #Identity Verified
    air_verified = pd.get_dummies(data.host_identity_verified, drop_first = True)
    air_verified.columns = ['verified']
    data = pd.concat([data,air_verified],axis = 1)
    data.drop('host_identity_verified',axis = 1,inplace = True)
    
    #Instant Bookable
    air_instant = pd.get_dummies(data.instant_bookable, drop_first = True)
    air_instant.columns = ['instant']
    data = pd.concat([data,air_instant],axis = 1)
    data.drop('instant_bookable',axis = 1,inplace = True)
    
    #Columnas name, neighbourhood y thumbnail_url
    data.drop('name',axis = 1, inplace = True)
    data.drop('neighbourhood',axis = 1, inplace = True)
    data.drop('thumbnail_url',axis = 1, inplace = True)
    
    #Zipcode
    data.zipcode = data.zipcode.apply(lambda x : re.findall('^\d+',x)).apply(lambda x : pd.to_numeric(x[0]))
    
    #Outliers
    def outliers(column):
        times = 0.5
        iqr = np.percentile(column,75) - np.percentile(column,25)
        upper = np.percentile(column,75) + times*iqr
        lower = np.percentile(column,25) - times*iqr
        return data[(column<lower) | (column>upper)]

    data.drop(outliers(data.number_of_reviews).index, inplace = True)
    data.drop(outliers(data.review_scores_rating).index, inplace = True)
    data.drop(outliers(data.amenity_items).index, inplace = True)
    data.drop(outliers(data.accommodates).index, inplace = True)
    data.drop(outliers(data.beds).index, inplace = True)
    data.drop(outliers(data.delta_first).index, inplace = True)
    data.drop(outliers(data.delta_host).index, inplace = True)
    data.drop(outliers(data.delta_host).index, inplace = True)


    return data

def cleaning_sub(data):
    #Property Type
    luxury = ['Treehouse','Villa','Timeshare','Castle','Tipi','Boat','Loft','Vacation home']
    low = ['Cabin','Bed & Breakfast','Yurt','Camper/RV','Hut','Tent','Hostel','Dorm']
    other = ['Guest suite','In-law','Boutique hotel','Serviced apartment','Chalet','Cave','Earth House','Train']
    data.property_type = data.property_type.apply(lambda x : 'Luxury' if x in luxury else x)\
                                               .apply(lambda x : 'Low' if x in low else x)\
                                               .apply(lambda x : 'Other' if x in other else x)
    air_prop_type = pd.get_dummies(data.property_type, drop_first=True)
    data = pd.concat([data,air_prop_type],axis = 1)
    data.drop('property_type',axis = 1,inplace = True)
    
    #Room Type
    entire = 198.166790/198.166790
    private = 81.995331/198.166790
    shared = 52.694215/198.166790    
    data.room_type = data.room_type.apply(lambda x : entire if x == 'Entire home/apt' else x)\
                                           .apply(lambda x : private if x == 'Private room' else x)\
                                           .apply(lambda x : shared if x == 'Shared room' else x)
    
    #Amenities
    data.amenities = data.amenities.str.replace('"translation missing: en.hosting_amenity_49"','')\
                                 .str.replace('"translation missing: en.hosting_amenity_50"','').str.split(',')
    amen = pd.DataFrame(data.amenities.apply(lambda x : len(x)))
    amen.columns = ['amenity_items']
    data = pd.concat([data,amen],axis = 1)
    data.drop('amenities',axis = 1, inplace = True)
    
    #Bed Type
    data.drop('bed_type',axis = 1, inplace = True)
    
    #Cancellation Policy
    data.cancellation_policy = data.cancellation_policy.str.replace('super_strict_30','strict')\
                                 .str.replace('super_strict_60','strict')
    air_canc_pol = pd.get_dummies(data.cancellation_policy, drop_first=True)
    data = pd.concat([data,air_canc_pol],axis = 1)
    data.drop('cancellation_policy',axis = 1,inplace = True)
    
    #Cleaning Fee
    air_clean_fee = pd.get_dummies(data.cleaning_fee, drop_first=True)
    air_clean_fee.columns = ['clean_fee']
    data = pd.concat([data,air_clean_fee],axis = 1)
    data.drop('cleaning_fee',axis = 1,inplace = True)
    
    #City
    air_city = pd.get_dummies(data.city, drop_first=True)
    data = pd.concat([data,air_city],axis = 1)
    data.drop('city',axis = 1,inplace = True)
    
    #Description
    data.drop('description',axis = 1, inplace = True)
    
    #Columnas de fechas
    data['today'] = pd.Timestamp.today()
    data['delta_first'] = (data.today - pd.to_datetime(data.first_review) )/np.timedelta64(1,'Y')
    data['delta_last'] = (data.today - pd.to_datetime(data.last_review) )/np.timedelta64(1,'Y')
    data['delta_host'] = (data.today - pd.to_datetime(data.host_since) )/np.timedelta64(1,'Y')
    data.drop(['first_review','host_since','last_review','today','id'],axis = 1, inplace = True)
    
    #Host Response Rate
    data.host_response_rate = data.host_response_rate.apply(lambda x : float(x.split('%')[0])/100)
    
    #Profile Pic
    data.drop('host_has_profile_pic',axis = 1, inplace = True)
    
    #Identity Verified
    air_verified = pd.get_dummies(data.host_identity_verified, drop_first = True)
    air_verified.columns = ['verified']
    data = pd.concat([data,air_verified],axis = 1)
    data.drop('host_identity_verified',axis = 1,inplace = True)
    
    #Instant Bookable
    air_instant = pd.get_dummies(data.instant_bookable, drop_first = True)
    air_instant.columns = ['instant']
    data = pd.concat([data,air_instant],axis = 1)
    data.drop('instant_bookable',axis = 1,inplace = True)
    
    #Columnas name, neighbourhood y thumbnail_url
    data.drop('name',axis = 1, inplace = True)
    data.drop('neighbourhood',axis = 1, inplace = True)
    data.drop('thumbnail_url',axis = 1, inplace = True)
    
    #Zipcode
    data.zipcode = data.zipcode.apply(lambda x : re.findall('^\d+',x)).apply(lambda x : pd.to_numeric(x[0]))
    return data