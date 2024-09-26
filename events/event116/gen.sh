lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 44.05393393393393 --fixed-mass2 53.550910910910915 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002213725.9638146 \
--gps-end-time 1002220925.9638146 \
--d-distr volume \
--min-distance 2478.2146676536977e3 --max-distance 2478.234667653698e3 \
--l-distr fixed --longitude 166.0853271484375 --latitude 16.517271041870117 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
